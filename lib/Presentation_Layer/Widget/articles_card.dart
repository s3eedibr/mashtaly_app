import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/colors.dart';

class ArticlesCard extends StatelessWidget {
  final int? id;
  final String? title;
  final String? desc;
  final String? type;
  final String? date;
  final String? imageURL;
  final String? user;

  const ArticlesCard({
    Key? key,
    required this.imageURL,
    required this.user,
    required this.title,
    this.id,
    this.desc,
    this.type,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildShimmerCard();
        } else {
          return _buildContentCard(
            imageURL: imageURL!,
            user: user!,
            title: title!,
          );
        }
      },
    );
  }

  Future<void> _loadData() async {
    // Simulate an asynchronous operation
    await Future.delayed(const Duration(seconds: 2));
  }

  static Widget buildShimmerCard() {
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

  Widget _buildContentCard({
    required String title,
    required String user,
    required String imageURL,
  }) {
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
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: SizedBox(
                      height: 150,
                      width: 250,
                      child: imageURL.isNotEmpty
                          ? Image.network(
                              imageURL,
                              height: 150,
                              width: 250,
                              fit: BoxFit.cover,
                            )
                          : const Placeholder(
                              color: Colors.grey,
                              fallbackHeight: 72,
                              fallbackWidth: 72,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: tPrimaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'by $user',
                    style: const TextStyle(
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
