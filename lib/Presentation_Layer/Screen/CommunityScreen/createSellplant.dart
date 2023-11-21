import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Constants/colors.dart';

class CreateSellplant extends StatefulWidget {
  const CreateSellplant({Key? key}) : super(key: key);

  @override
  State<CreateSellplant> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreateSellplant> {
  final List<XFile> _selectedImages = [];

  pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: source,
      imageQuality: 25,
    );
    if (file != null) {
      setState(() {
        _selectedImages.add(file);
      });
    } else {
      print("no image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        title: const Text(
          "Create a Sell",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text("Select Image from"),
                            children: [
                              SimpleDialogOption(
                                padding: const EdgeInsets.all(6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        await pickImage(ImageSource.camera);
                                      },
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.camera_alt_rounded),
                                          Text("Camera"),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                        await pickImage(ImageSource.gallery);
                                      },
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                    },
                    child: Container(
                      height: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: _selectedImages.isNotEmpty
                          ? Image.file(
                              File(_selectedImages[0].path),
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              FontAwesomeIcons.plus,
                              color: tSearchIconColor,
                              size: 55,
                            ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text("Select Image from"),
                          children: [
                            SimpleDialogOption(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.camera);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.camera_alt_rounded),
                                        Text("Camera"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.gallery);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 1
                        ? Image.file(
                            File(_selectedImages[1].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text("Select Image from"),
                          children: [
                            SimpleDialogOption(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.camera);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.camera_alt_rounded),
                                        Text("Camera"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.gallery);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 2
                        ? Image.file(
                            File(_selectedImages[2].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text("Select Image from"),
                          children: [
                            SimpleDialogOption(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.camera);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.camera_alt_rounded),
                                        Text("Camera"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.gallery);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 3
                        ? Image.file(
                            File(_selectedImages[3].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text("Select Image from"),
                          children: [
                            SimpleDialogOption(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.camera);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.camera_alt_rounded),
                                        Text("Camera"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      await pickImage(ImageSource.gallery);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 4
                        ? Image.file(
                            File(_selectedImages[4].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomField(
              titleField: 'Title',
              heightField: 65,
              maxLine: 1,
              maxLength: 20,
            ),
            const CustomField(
              titleField: 'Content',
              heightField: 180,
              maxLine: 50,
              maxLength: 2000,
            ),
            const SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
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
              "Publish",
              style: TextStyle(
                color: tThirdTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.titleField,
    required this.heightField,
    required this.maxLine,
    required this.maxLength,
  }) : super(key: key);

  final String titleField;
  final double heightField;
  final int maxLine;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          titleField,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0x7C0D1904),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: heightField,
          width: 375,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "This field is required";
              } else {
                return null;
              }
            },
            maxLines: maxLine,
            maxLength: maxLength,
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
    );
  }
}
