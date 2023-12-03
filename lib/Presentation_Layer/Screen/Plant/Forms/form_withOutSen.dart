import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mashtaly_app/Business_Layer/cubits/plant/plantCubit.dart';
import 'package:mashtaly_app/sql.dart';
import '../../../../Constants/colors.dart';
import '../../../Widget/snakBar.dart';
import '../Widget/customdropdown.dart';
import 'Utils.dart';

import '../../HomeScreens/home_screen.dart';

class AddPlantFormWithOutSen extends StatefulWidget {
  const AddPlantFormWithOutSen({Key? key}) : super(key: key);

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
  File? _image;
  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to capture an image from the camera
  Future<void> _captureImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  late Future<TimeOfDay?> selectedTime;
  String time = " ";
  String? selectedImagePath;

  SqlDb sqlDb = SqlDb();

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
          _buildPlantImage(),
          _buildPlantNameInput(),
          _buildWateringSizeInput(),
          _buildDateRangeInput(),
          _buildDelayedWateringInput(),
          const SizedBox(height: 10),
          _buildScheduleHeader(),
          const SizedBox(height: 10),
          _buildDaySchedule(),
          const SizedBox(height: 110),
        ],
      ),
      floatingActionButton: _buildSaveScheduleButton(),
    );
  }

  Widget _buildPlantImage() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            selectImageDialog(context);
          },
          child: Container(
            height: 200,
            width: 379.4,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: _image != null
                ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    FontAwesomeIcons.plus,
                    color: tSearchIconColor,
                    size: 55,
                  ),
          ),
        ),
      ],
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
                onTap: () {},
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
                    Image.asset(
                      'assets/images/icons/Path 754561.png',
                      height: 24,
                      width: 24,
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

  Widget _buildWateringSizeInput() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 25),
          const Text(
            "Amount of water per watering",
            style: TextStyle(
              fontSize: 15,
              color: Color(0x7C0D1904),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 40,
            width: 375,
            child: TextFormField(
              controller: amountOfWaterController,
              keyboardType: TextInputType.number,
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
        ],
      ),
    );
  }

  Widget _buildDateRangeInput() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateRangeInputColumn(
            'From',
            () {
              showDialogDatePicker(context, fromDateController);
            },
            fromDateController,
          ),
          _buildDateRangeInputColumn(
            'Until',
            () {
              showDialogDatePicker(context, untilDateController);
            },
            untilDateController,
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeInputColumn(
      String labelText, VoidCallback onTap, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 25),
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0x7C0D1904),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          width: 150,
          child: TextFormField(
            onTap: onTap,
            readOnly: true,
            controller: controller,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 12,
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
      ],
    );
  }

  Widget _buildDelayedWateringInput() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDelayedWateringColumn("Delayed Watering", FontAwesomeIcons.plus,
              () {
            showDialogTimePicker(context);
          }),
          _buildDelayedWateringColumn("If", FontAwesomeIcons.plus, () {
            showDropdown(context);
          }),
        ],
      ),
    );
  }

  Widget _buildDelayedWateringColumn(
      String labelText, IconData icon, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0x7C0D1904),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 40,
            width: 150,
            decoration: const BoxDecoration(
              color: Color(0xffD2D8CF),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleHeader() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 35),
          const Text(
            "Schedule",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          _buildWeekButtons(),
        ],
      ),
    );
  }

  Widget _buildWeekButtons() {
    return SizedBox(
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
    );
  }

  Widget _buildDaySchedule() {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 16),
      child: Visibility(
        visible: selectedWeek >= 1 && selectedWeek <= weeklySchedules.length,
        child: SizedBox(
          height: 92,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final dayNames = weeklySchedules[selectedWeek - 1];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 12,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 8,
                          left: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayNames[index],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialogTimePicker(context);
                              },
                              child: const Text(
                                '+  Add Time',
                                style: TextStyle(
                                  color: tPrimaryActionColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSaveScheduleButton() {
    return SizedBox(
      height: 50,
      width: 380,
      child: FloatingActionButton(
        backgroundColor: tPrimaryActionColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        onPressed: () async {
          try {
            if (_image == null) {
              print('Error: Please select an image.');
              showSnakBar(context, 'Please select an image.');
              return;
            }

            if (plantNameController.text.isEmpty) {
              print('Error: Please enter plant name.');
              showSnakBar(context, 'Please enter plant name.');
              return;
            }
            if (amountOfWaterController.text.isEmpty) {
              print('Error: Please enter Amount of water per watering.');
              showSnakBar(
                  context, 'Please enter amount of water per watering.');
              return;
            }

            var plantCubit = BlocProvider.of<PlantCubit>(context);
            plantCubit.addPlant(
              imageFile: _image,
              plantName: plantNameController.text.trim(),
              amountOfWater:
                  double.tryParse(amountOfWaterController.text.trim()) ?? 0.0,
            );
            Navigator.of(context).pop();
          } catch (e) {
            print('Error adding plant: $e');
            showSnakBar(context, 'Error adding plant: $e');
          }
        },
        child: const Center(
          child: Text(
            "Save Schedule",
            style: TextStyle(
              color: tThirdTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

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
        return AlertDialog(
          title: const Text('Select an image'),
          content: CustomDropdown(
            onImageSelected: (String? imagePath) {
              setState(() {
                selectedImagePath = imagePath;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  // Show options for selecting image from gallery or camera
  Future<dynamic> selectImageDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Select Image from"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      _captureImageFromCamera();
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        Text("Camera"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      _pickImageFromGallery();
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.image),
                        Text("Gallery"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
