import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Constants/colors.dart';

class PostCard3 extends StatelessWidget {
  final int? id;
  final String? title;
  final String? desc;
  final String? type;
  final String? date;
  final String? imageURL;
  final String? user;

  const PostCard3({
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

  Future<dynamic> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  static Widget buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Container(
                    color: Colors.grey[300],
                    height: 82,
                    width: 82,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey[300],
                        height: 16,
                        width: 150,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey[300],
                        height: 16,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              ],
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
          height: 15,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 82,
                  width: 82,
                  child: imageURL.isNotEmpty
                      ? Image.network(
                          imageURL,
                          height: 82,
                          width: 82,
                          fit: BoxFit.cover,
                        )
                      : const Placeholder(
                          color: Colors.grey,
                          fallbackHeight: 82,
                          fallbackWidth: 82,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
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
            ],
          ),
        ),
      ],
    );
  }
}
