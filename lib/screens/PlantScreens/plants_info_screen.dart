import 'package:flutter/material.dart';

class PlantsInfoScreen extends StatefulWidget {
  const PlantsInfoScreen({super.key});

  @override
  State<PlantsInfoScreen> createState() => _PlantsInfoScreenState();
}

class _PlantsInfoScreenState extends State<PlantsInfoScreen> {
  List<String> images = [
    'assets/images/plants_info_images/0a6c1f051b5d941f4f2056b417403f9c5a5c4102.jpg',
    'assets/images/plants_info_images/1c3de460830f2028d5666fc8db1db3f0d4bfb5c7.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Plants Information",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 16,
          bottom: 5,
          left: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/plants_info_images/3d74853a74cef709e1750aa4f7083c55dee7f616.jpg',
                height: 225,
                width: width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        images[index],
                        height: 62.5,
                        width: 64,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
