import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Business_Layer/cubits/add_plant/add_plant_Cubit.dart';
import '../../../../../Constants/colors.dart';
import '../../../../Widget/snackBar.dart';

class SaveScheduleButton extends StatefulWidget {
  final dynamic currentUserUid,
      image,
      plantNameController,
      amountOfWaterController,
      fromDateController,
      untilDateController;

  const SaveScheduleButton(
      {super.key,
      this.currentUserUid,
      this.image,
      this.plantNameController,
      this.amountOfWaterController,
      this.fromDateController,
      this.untilDateController});
  @override
  _SaveScheduleButtonState createState() => _SaveScheduleButtonState();
}

class _SaveScheduleButtonState extends State<SaveScheduleButton> {
  bool isLoading = false;

  Widget buildSaveScheduleButton(
    BuildContext context,
    image,
    currentUserUid,
    plantNameController,
    amountOfWaterController,
    fromDateController,
    untilDateController,
  ) {
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
                  "Publish",
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
    );
  }
}
