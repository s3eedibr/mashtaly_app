import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mashtaly_app/Presentation_Layer/Widget/snackBar.dart';
import '../../../../Constants/colors.dart';
import '../../../../Services/scan_plant_service.dart';
import 'Widget/date_RangeInput.dart';
import 'Widget/delayed_Watering_Column.dart';
import 'Widget/delayed_Watering_Input.dart';
import 'Widget/plant_Image.dart';
import 'Widget/save_Schedule_Button.dart';
import 'Widget/schedule_Header.dart';
import 'Widget/schedule_Widget.dart';
import 'Widget/watering_Amount_Input.dart';
import 'Utils.dart';

import '../../HomeScreens/home_screen.dart';
import 'Widget/weather_Condition_Column.dart';

class AddPlantFormWithOutSen extends StatefulWidget {
  const AddPlantFormWithOutSen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPlantFormWithOutSen> createState() => _AddPlantFormWithOutSenState();
}

class _AddPlantFormWithOutSenState extends State<AddPlantFormWithOutSen> {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController untilDateController = TextEditingController();
  final TextEditingController plantNameController = TextEditingController();
  final TextEditingController amountOfWaterController = TextEditingController();
  final ScanPlantService _scanPlantService = ScanPlantService();

  XFile? image;

  Future<void> sendToApi() async {
    try {
      final imageFile = image;
      if (imageFile == null) {
        print('Error: Please select an image.');
        showSnackBar(context, 'Please select an image.');
        return;
      }

      plantName = null;
      final response = await _scanPlantService.sendImageToApi(imageFile);

      // Process the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          plantName = responseData['results'][0]['species']
              ['scientificNameWithoutAuthor'];
          commonName = responseData['results'][0]['species']['commonNames'][0];
        });
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
        sendToApi();
      });
    }
  }

// Function to capture an image from the camera
  Future<void> captureImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
        sendToApi();
      });
    }
  }

  late String? plantName = '';
  late String? commonName = '';
  late String currentUserUid;

  @override
  void initState() {
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  }

  List<DelayedWateringInput> delayedCondition = [const DelayedWateringInput()];
  List<List<dynamic>> weatherConditionAndDuration = [];
  List<List<dynamic>> combineWeatherAndDuration() {
    List<List<dynamic>> combinedList = [];
    for (int i = 0; i < duration.length; i++) {
      if (i < weatherCondition.length) {
        combinedList.add([
          weatherCondition[i],
          duration[i][0], // days
          duration[i][1], // hours
          duration[i][2], // minutes
        ]);
      }
    }
    return combinedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.xmark,
            ),
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
              delayedCondition.clear();
              weatherCondition.clear();
              duration.clear();
              timeInEachWeekAndDay.clear();
            }),
        title: const Text(
          "Add Plant / Without sensor",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          const SizedBox(height: 10),
          buildPlantImage(
            context,
            image,
            pickImageFromGallery,
            captureImageFromCamera,
          ),
          _buildPlantNameInput(),
          buildWateringSizeInput(
            amountOfWaterController,
          ),
          buildDateRangeInput(
            context,
            fromDateController,
            untilDateController,
            showDialogDatePicker,
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16, bottom: 0, left: 17),
            child: Row(
              children: [
                Text(
                  'Delayed watering',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0x7C0D1904),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Text(
                  'If',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0x7C0D1904),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: delayedCondition.length,
              itemBuilder: (context, index) {
                return delayedCondition[index];
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (duration.isNotEmpty && weatherCondition.isNotEmpty) {
                addDelayedCondition();
              } else {
                showSnackBar(context,
                    "Enter all the information in the previous fields first");
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
              child: Container(
                height: 40,
                width: 170,
                decoration: const BoxDecoration(
                  color: Color(0xffD2D8CF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              print(combineWeatherAndDuration());
              print(delayedCondition);
              print(weatherCondition);
              print(duration);
              print(timeInEachWeekAndDay);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
              child: Container(
                height: 40,
                width: 170,
                decoration: const BoxDecoration(
                  color: Color(0xffD2D8CF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.print,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          buildScheduleHeader(),
          const ScheduleWidget(),
          const SizedBox(height: 75),
        ],
      ),
      floatingActionButton: SaveScheduleButton(
        currentUserUid: currentUserUid,
        image: image,
        plantNameController: plantNameController,
        amountOfWaterController: amountOfWaterController,
        fromDateController: fromDateController,
        untilDateController: untilDateController,
        withSensor: false,
      ),
    );
  }

  int days = 0, hours = 0, min = 0;
  Widget _buildPlantNameInput() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 25),
          const Text(
            "Plant Name",
            style: TextStyle(
              fontSize: 15,
              color: Color(0x7C0D1904),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 300,
                child: TextFormField(
                  controller: plantNameController,
                  keyboardType: TextInputType.text,
                  cursorColor: tPrimaryActionColor,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 15,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: plantName != null
                    ? () {
                        setState(() {
                          plantNameController.text = plantName!;
                        });
                      }
                    : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    plantName != null
                        ? const Icon(
                            Icons.search_rounded,
                            size: 24,
                            color: Colors.white,
                          )
                        : const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimee = TimeOfDay.now();

  void showDialogDatePicker(
      BuildContext context, TextEditingController controller) {
    // Use the controller to get and set the date
    DateTime initialDate = controller.text.isNotEmpty
        ? Utils.parseFormattedDateSimple(controller.text)
        : DateTime.now();

    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: tPrimaryActionColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: tPrimaryTextColor,
            ),
          ),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if (value == null) return;
        controller.text =
            Utils.getFormattedDateSimple(value.millisecondsSinceEpoch);
        print(controller.text);
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  Future<void> selectDateTime(BuildContext context) async {
    DateTime initialDate = selectedDate;
    TimeOfDay initialTime = selectedTimee;

    // Show Date Picker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != initialDate) {
      // Update selected date
      setState(() {
        selectedDate = pickedDate;
      });

      // Show Time Picker
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null && pickedTime != initialTime) {
        // Update selected time
        setState(() {
          selectedTimee = pickedTime;
        });

        // Handle the selected date and time as needed
        print("Selected Date: $selectedDate");
      }
    }
  }

  addDelayedCondition() {
    setState(() {});
    delayedCondition.add(const DelayedWateringInput());
  }
}
