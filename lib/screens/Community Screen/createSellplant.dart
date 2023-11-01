import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Constants/colors.dart';

class CreateSellplant extends StatefulWidget {
  const CreateSellplant({super.key});

  @override
  State<CreateSellplant> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreateSellplant> {
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
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddImage(),
                AddImage(),
                AddImage(),
                AddImage(),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomField(
              titleField: 'Title',
              heightField: 40,
              maxLine: 1,
            ),
            const CustomField(
              titleField: 'Content',
              heightField: 180,
              maxLine: 50,
            ),
            const SizedBox(
              height: 25,
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
  }) : super(key: key);

  final String titleField;
  final double heightField;
  final int maxLine;
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

class AddImage extends StatelessWidget {
  const AddImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 95,
        width: 85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: const Icon(
          FontAwesomeIcons.plus,
          color: tSearchIconColor,
          size: 25,
        ),
      ),
    );
  }
}
