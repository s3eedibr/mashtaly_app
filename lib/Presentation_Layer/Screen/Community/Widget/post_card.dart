import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Constants/colors.dart';

class PostCard extends StatelessWidget {
  final int? id;
  final String? title;
  final String? desc;
  final String? type;
  final String? date;
  final String? imageURL;
  final String? user;

  const PostCard({
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(
                color: tSearchBarColor,
                width: 2,
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
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      child: Container(
                        height: 150,
                        width: 250,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16,
                      width: 200,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
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
                          ? CachedNetworkImage(
                              imageUrl: imageURL,
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
