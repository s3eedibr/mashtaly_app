import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/assets.dart';
import '../../Constants/colors.dart';

class ArticlesCard extends StatelessWidget {
  final bool isLoading;
  final int? id;
  final String? title;
  final String? desc;
  final String? type;
  final String? date;

  const ArticlesCard({
    Key? key,
    required this.isLoading,
    this.id,
    this.title,
    this.desc,
    this.type,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmerCard();
    } else {
      return _buildContentCard();
    }
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
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
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey[300],
                      height: 150,
                      width: 250,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      color: Colors.grey[300],
                      height: 16,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.grey[300],
                      height: 16,
                      width: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard() {
    // Replace this with your actual content card
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
