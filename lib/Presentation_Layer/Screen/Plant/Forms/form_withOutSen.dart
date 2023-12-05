import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:mashtaly_app/sql.dart';
import '../../../../Constants/colors.dart';
import '../../../../Services/scan_plant_service.dart';
import 'Widget/dateRangeInput.dart';
import 'Widget/daySchedule.dart';
import 'Widget/delayedWateringInput.dart';
import 'Widget/plantImage.dart';
import 'Widget/saveScheduleButton.dart';
import 'Widget/scheduleHeader.dart';
import 'Widget/wateringSizeInput.dart';
import 'Widget/customdropdown.dart';
import 'Utils.dart';

import '../../HomeScreens/home_screen.dart';

class AddPlantFormWithOutSen extends StatefulWidget {
  const AddPlantFormWithOutSen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPlantFormWithOutSen> createState() => _AddPlantFormWithOutSenState();
}

class _AddPlantFormWithOutSenState extends State<AddPlantFormWithOutSen> {
  int selectedWeek = -1;

  List<List<String>> weeklySchedules = [
    [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ],
    [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ],
    [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ],
    [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ],
  ];

  void selectWeek(int weekNumber) {
    setState(() {
      selectedWeek = weekNumber;
    });
  }

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController untilDateController = TextEditingController();
  final TextEditingController plantNameController = TextEditingController();
  final TextEditingController amountOfWaterController = TextEditingController();
  final ScanPlantService _scanPlantService = ScanPlantService();

  File? _image;
  Future<void> sendToApi() async {
    try {
      final imageFile = _image;

      final response = await _scanPlantService.sendImageToApi(imageFile!);

      // Process the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        plantName = responseData['results'][0]['species']
            ['scientificNameWithoutAuthor'];
        commonName = responseData['results'][0]['species']['commonNames'][0];
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
        _image = File(pickedFile.path);
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
        _image = File(pickedFile.path);
        sendToApi();
      });
    }
  }

  late Future<TimeOfDay?> selectedTime = Future.value(TimeOfDay.now());
  String? time;
  String? selectedImagePath;
  String? selectedWeatherText;

  late String? plantName = '';
  late String? commonName = '';
  // SqlDb sqlDb = SqlDb();
  late String currentUserUid;
  @override
  void initState() {
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  }

  DateTime delayedDate = DateTime.now();
  TimeOfDay delayedTime = TimeOfDay.now();

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
          onPressed: () => Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          ),
        ),
        title: const Text(
          "Add Plant",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          const SizedBox(height: 10),
          buildPlantImage(
              context, _image, pickImageFromGallery, captureImageFromCamera),
          _buildPlantNameInput(),
          buildWateringSizeInput(amountOfWaterController),
          buildDateRangeInput(context, fromDateController, untilDateController,
              showDialogDatePicker),
          buildDelayedWateringInput(context, delayedDateTime, showDropdown,
              calculateDuration(), selectedImagePath, selectedWeatherText),
          buildScheduleHeader(),
          _buildWeekButtons(),
          const SizedBox(height: 10),
          buildDaySchedule(
              selectedWeek, weeklySchedules, showDialogTimePicker, time),
          const SizedBox(height: 110),
        ],
      ),
      floatingActionButton: buildSaveScheduleButton(context, currentUserUid,
          _image, plantNameController, amountOfWaterController),
    );
  }

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
                        : const CircularProgressIndicator(
                            color: Colors.white,
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

  Widget _buildWeekButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 16),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final List<String> weekNum = [
              'Week 1',
              'Week 2',
              'Week 3',
              'Week 4',
            ];
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWeek = index + 1;
                  });
                },
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: selectedWeek == index + 1
                        ? tPrimaryActionColor
                        : tBgColor,
                    border: selectedWeek == index + 1
                        ? Border.all(color: Colors.transparent)
                        : Border.all(width: 1, color: tSearchIconColor),
                  ),
                  child: Center(
                    child: Text(
                      weekNum[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: selectedWeek == index + 1
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: selectedWeek == index + 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
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
        print("Selected Time: $selectedTime");
      }
    }
  }

  void showDialogTimePicker(BuildContext context) {
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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

    // When the user selects a time, update the state of the widget with the new time value.
    selectedTime.then((value) {
      setState(() {
        if (value == null) return;
        time = Utils.getFormattedTimeSimple(
            DateTime(2023, 1, 1, value.hour, value.minute)
                .millisecondsSinceEpoch);
        print(time);
      });
    }, onError: (error) {
      // Handle any errors that occur when selecting a time (e.g. user cancels).
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 40,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: const EdgeInsets.only(left: 16, right: 17),
            content: CustomDropdown(
              onChange: (Map<String, dynamic>? selectedItem) {
                setState(() {
                  selectedImagePath = selectedItem?['path'];
                  selectedWeatherText = selectedItem?['text'];
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> delayedDateTime(BuildContext context) async {
    DateTime initialDate = delayedDate;
    TimeOfDay initialTime = delayedTime;

    DateTime? pickedDateTime = await showDatePicker(
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

    if (pickedDateTime != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
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

      if (pickedTime != null) {
        pickedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          delayedDate = pickedDateTime!;
          delayedTime = pickedTime;
          print(pickedDateTime);
          print(pickedTime);
        });
      }
    }
  }

  String calculateDuration() {
    // Calculate the total duration in days and hours
    DateTime now = DateTime.now();
    DateTime selectedDateTime = DateTime(
      delayedDate.year,
      delayedDate.month,
      delayedDate.day,
      delayedTime.hour,
      delayedTime.minute,
    );

    Duration selectedDuration = selectedDateTime.difference(now);

    // Calculate days and hours separately
    int days = selectedDuration.inDays;
    int hours = (selectedDuration.inHours % 24);

    return '$days days, $hours hours';
  }
}
