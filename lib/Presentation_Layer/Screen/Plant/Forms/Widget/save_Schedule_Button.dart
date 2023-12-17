import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Plant/Forms/Widget/delayed_Watering_Column.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Plant/Forms/Widget/weather_Condition_Column.dart';

import '../../../../../Business_Layer/cubits/add_plant/add_plant_Cubit.dart';
import '../../../../../Constants/colors.dart';
import '../../../../Widget/snackBar.dart';

class SaveScheduleButton extends StatefulWidget {
  final dynamic currentUserUid,
      image,
      plantNameController,
      amountOfWaterController,
      fromDateController,
      untilDateController,
      withSensor,
      editMood;

  const SaveScheduleButton({
    super.key,
    this.currentUserUid,
    this.image,
    this.plantNameController,
    this.amountOfWaterController,
    this.fromDateController,
    this.untilDateController,
    this.withSensor,
    this.editMood,
  });
  @override
  _SaveScheduleButtonState createState() => _SaveScheduleButtonState();
}

class _SaveScheduleButtonState extends State<SaveScheduleButton> {
  bool isLoading = false;
  late bool editMood;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editMood = widget.editMood;
  }

  Widget buildSaveScheduleButton(
    BuildContext context,
    image,
    currentUserUid,
    plantNameController,
    amountOfWaterController,
    fromDateController,
    untilDateController,
    withSensor,
    editMood,
  ) {
    return SizedBox(
      height: 50,
      width: 380,
      child: editMood != true
          ? FloatingActionButton(
              backgroundColor: tPrimaryActionColor,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              onPressed: () async {
                try {
                  if (image == null) {
                    print('Error: Please select an image.');
                    showSnackBar(context, 'Please select an image.');
                    return;
                  }

                  if (plantNameController.text.isEmpty) {
                    print('Error: Please enter plant name.');
                    showSnackBar(context, 'Please enter plant name.');
                    return;
                  }

                  var plantCubit = BlocProvider.of<AddPlantCubit>(context);
                  plantCubit.addPlant(
                    image,
                    currentUserUid,
                    plantNameController,
                    amountOfWaterController,
                    fromDateController,
                    untilDateController,
                    withSensor,
                  );

                  setState(() {
                    isLoading = true;
                  });

                  setState(() {
                    isLoading = false;
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error adding plant: $e');
                  showSnackBar(context, 'Error adding plant: $e');
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Center(
                child: isLoading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            'Please wait...',
                            style: TextStyle(
                              color: tThirdTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      )
                    : const Text(
                        "Save Schedule",
                        style: TextStyle(
                          color: tThirdTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      color: tThirdTextErrorColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Center(
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: tPrimaryActionColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        color: tPrimaryActionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (image == null) {
                        showSnackBar(context, 'Please select an image.');
                        return;
                      }

                      if (plantNameController.text.isEmpty) {
                        showSnackBar(context, 'Please enter plant name.');
                        return;
                      }

                      var plantCubit = BlocProvider.of<AddPlantCubit>(context);
                      plantCubit.addPlant(
                        image,
                        currentUserUid,
                        plantNameController,
                        amountOfWaterController,
                        fromDateController,
                        untilDateController,
                        withSensor,
                      );

                      setState(() {
                        isLoading = true;
                      });

                      setState(() {
                        isLoading = false;
                      });
                      duration.clear();
                      weatherCondition.clear();
                      Navigator.of(context).pop();
                    } catch (e) {
                      // print('Error adding plant: $e');
                      showSnackBar(context, 'Error adding plant: $e');
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 155,
                    decoration: const BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Save",
                              style: TextStyle(
                                color: tThirdTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSaveScheduleButton(
      context,
      widget.image,
      widget.currentUserUid,
      widget.plantNameController,
      widget.amountOfWaterController,
      widget.fromDateController,
      widget.untilDateController,
      widget.withSensor,
      widget.editMood,
    );
  }
}
