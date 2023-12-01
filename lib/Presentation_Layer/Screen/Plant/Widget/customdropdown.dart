import 'package:flutter/material.dart';
import 'package:mashtaly_app/Constants/assets.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<String> imagePaths = [
    Assets.assetsImagesIconsDefaultProfile,
    Assets.assetsImagesIconsDefaultProfile,
    Assets.assetsImagesIconsDefaultProfile,
    Assets.assetsImagesIconsDefaultProfile,
  ];

  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        selectedImagePath != null
            ? Image.asset(
                selectedImagePath!,
                width: 100,
                height: 100,
              )
            : Container(),
        DropdownButton<String>(
          hint: const Text('Select an image'),
          value: selectedImagePath,
          onChanged: (String? value) {
            setState(() {
              selectedImagePath = value;
            });
          },
          items: imagePaths.asMap().entries.map<DropdownMenuItem<String>>(
            (entry) {
              int index = entry.key;
              String path = entry.value;
              return DropdownMenuItem<String>(
                value: '$index-$path', // Use index as a unique identifier
                child: Image.asset(
                  path,
                  width: 50,
                  height: 50,
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
