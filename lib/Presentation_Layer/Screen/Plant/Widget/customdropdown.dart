import 'package:flutter/material.dart';

import '../../../../Constants/assets.dart';

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
