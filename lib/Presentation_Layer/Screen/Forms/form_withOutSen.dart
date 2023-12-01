import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Constants/assets.dart';
import '../../../Constants/colors.dart';
import 'Utils.dart';

import '../HomeScreens/home_screen.dart';

class AddPlantFormWithOutSen extends StatefulWidget {
  const AddPlantFormWithOutSen({Key? key}) : super(key: key);

  @override
  State<AddPlantFormWithOutSen> createState() => _AddPlantFormWithOutSenState();
}

class _AddPlantFormWithOutSenState extends State<AddPlantFormWithOutSen> {
  int selectedWeek = -1; // Initialize with -1, indicating no button selected.

  void selectWeek(int weekNumber) {
    setState(() {
      selectedWeek = weekNumber;
    });
  }

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController untilDateController = TextEditingController();

  late Future<TimeOfDay?> selectedTime;
  String time = " ";
  String? selectedImagePath;

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
          _buildPlantNameInput(),
          _buildWateringSizeInput(),
          _buildDateRangeInput(),
          _buildDelayedWateringInput(),
          const SizedBox(height: 35),
          _buildScheduleHeader(),
          const SizedBox(height: 10),
          _buildDaySchedule(),
          const SizedBox(height: 110),
        ],
      ),
      floatingActionButton: _buildSaveScheduleButton(),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
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
            "Size of Water per Watering",
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              },
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
                  selectWeek(index + 1);
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
        visible: selectedWeek == 1 ||
            selectedWeek == 2 ||
            selectedWeek == 3 ||
            selectedWeek == 4,
        child: SizedBox(
          height: 92,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final List<String> dayNames = [
                'Sunday',
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
              ];
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
                            bottomRight: Radius.circular(16)),
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
                              onTap: () {},
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
        onPressed: () {},
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
}

class CustomDropdown extends StatelessWidget {
  final ValueChanged<String?> onImageSelected;

  const CustomDropdown({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      Assets.assetsImagesIconsCommunities, Assets.assetsImagesIconsCommunities,
      Assets.assetsImagesIconsCommunities, Assets.assetsImagesIconsCommunities,
      // Add more image paths as needed
    ];

    return DropdownButton<String>(
      hint: const Text('Select an image'),
      value: null,
      onChanged: (String? value) {
        onImageSelected(value);
      },
      items: imagePaths.asMap().entries.map<DropdownMenuItem<String>>(
        (entry) {
          String path = entry.value;
          return DropdownMenuItem<String>(
            value: path, // Use image path as a unique identifier
            child: Image.asset(
              path,
              width: 50,
              height: 50,
            ),
          );
        },
      ).toList(),
    );
  }
}
