import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/colors.dart';
import '../HomeScreens/home_screen.dart';

class AddPlantForm extends StatefulWidget {
  const AddPlantForm({super.key});

  @override
  State<AddPlantForm> createState() => _AddPlantFormState();
}

class _AddPlantFormState extends State<AddPlantForm> {
  int selectedWeek = -1; // Initialize with -1, indicating no button selected.

  void selectWeek(int weekNumber) {
    setState(() {
      selectedWeek = weekNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            "Add Plant / With Sensor",
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
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Sensor Name",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0x7C0D1904),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                            onTap: () {
                              AppSettings.openAppSettings(
                                type: AppSettingsType.wifi,
                              );
                            },
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
                                  'assets/images/icons/settings.png',
                                  height: 25,
                                  width: 25,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        "Plant Name",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0x7C0D1904),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        "Size of Water per Watering",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0x7C0D1904),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "From",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0x7C0D1904),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.datetime,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "Until",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0x7C0D1904),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.datetime,
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "Delayed Watering",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0x7C0D1904),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.datetime,
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
                                fillColor: Color(0xffD2D8CF),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffD2D8CF),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffD2D8CF),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "If",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0x7C0D1904),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.datetime,
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
                                fillColor: Color(0xffD2D8CF),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffD2D8CF),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffD2D8CF),
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
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Schedule",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    width: 400,
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
                          child: SizedBox(
                            height: 35,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectWeek(index + 1);
                                });
                              },
                              style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(0),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return selectedWeek == index + 1
                                        ? tPrimaryActionColor
                                        : tBgColor;
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return selectedWeek == index + 1
                                        ? Colors.white
                                        : Colors.black;
                                  },
                                ),
                                side: MaterialStateProperty.resolveWith<
                                    BorderSide>(
                                  (Set<MaterialState> states) {
                                    return selectedWeek == index + 1
                                        ? BorderSide.none
                                        : const BorderSide(
                                            width: 1, color: tSearchIconColor);
                                  },
                                ),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          16.0), // Adjust the border radius as needed
                                    );
                                  },
                                ),
                              ),
                              child: selectedWeek == index + 1
                                  ? Text(
                                      weekNum[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  : Text(
                                      weekNum[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
            ),
            // Column(
            //   children: [
            //     Container(
            //       height: 12,
            //       width: 120,
            //       decoration: const BoxDecoration(
            //         color: tPrimaryActionColor,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(16),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 80,
            //       width: 120,
            //       decoration: const BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(16),
            //             bottomRight: Radius.circular(16)),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.only(
            //           right: 8,
            //           left: 8,
            //         ),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const Text(
            //               'Sunday',
            //               style: TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //             GestureDetector(
            //               onTap: () {},
            //               child: const Text(
            //                 '+  Add Time',
            //                 style: TextStyle(
            //                   color: tPrimaryActionColor,
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 16),
              child: SizedBox(
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
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
