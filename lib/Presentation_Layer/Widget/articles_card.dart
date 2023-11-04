import 'package:flutter/material.dart';

import '../../Constants/assets.dart';
import '../../Constants/colors.dart';

class articlesCard extends StatelessWidget {
  final int? id;
  final String? title;
  final String? desc;
  final String? type;
  final String? date;

  const articlesCard(
      {super.key, this.id, this.title, this.desc, this.type, this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(
                left: 16,
                top: 8,
                right: 16,
                bottom: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(
                        Assets.assetsImagesPlantsInfoImagesMaskGroup17),
                    height: 150,
                    width: 250,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Title of article',
                    style: TextStyle(
                      fontSize: 16,
                      color: tPrimaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'by user',
                    style: TextStyle(
                      fontSize: 16,
                      color: tSecondTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
