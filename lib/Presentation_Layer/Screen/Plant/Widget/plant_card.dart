// ignore_for_file: public_member_api_docs, sort_constructors_first
// Update PlantCard to use the loaded data
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:mashtaly_app/Constants/assets.dart';

import '../../../../Constants/colors.dart';

class PlantCard extends StatelessWidget {
  final String? plantName;
  final String? status;
  final String? imageURL;
  final String? firstWatering;
  final bool? active;
  const PlantCard({
    Key? key,
    this.plantName,
    this.status,
    this.imageURL,
    this.firstWatering,
    this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContentCard(
      imageFile: imageURL!,
      plantName: plantName!,
    );
  }

  Widget _buildContentCard({
    required String plantName,
    required String imageFile,
    String? status,
    String? firstWatering,
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
            height: 280,
            width: 210,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: imageFile.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageFile,
                            height: 120,
                            width: 180,
                            fit: BoxFit.cover,
                            placeholder: (BuildContext context, String url) =>
                                const Center(
                                    child: CircularProgressIndicator(
                              color: tPrimaryActionColor,
                            )),
                            errorWidget: (BuildContext context, String url,
                                    dynamic error) =>
                                const Center(
                              child: Icon(Icons
                                  .signal_wifi_connected_no_internet_4_rounded),
                            ),
                          )
                        : const Placeholder(
                            color: Colors.grey,
                            fallbackHeight: 72,
                            fallbackWidth: 72,
                          ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Text(
                      plantName,
                      softWrap: false,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  active == true
                      ? Container(
                          height: 40,
                          width: 90,
                          decoration: const BoxDecoration(
                            color: tWateringColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 90,
                          decoration: const BoxDecoration(
                            color: tDelayedTextColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Off',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  active == true
                      ? Row(
                          children: [
                            Image.asset(
                              Assets.assetsImagesIconsGroup200,
                              height: 34,
                              width: 34,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              '25 days 12hr',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: tWateringColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Image.asset(
                              Assets.assetsImagesIconsGroup201,
                              height: 34,
                              width: 34,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              '25 days 12hr',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: tDelayedTextColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
            height: 280,
            width: 210,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
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
                        height: 120,
                        width: 180,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
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
                      height: 20,
                      width: 150,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 40,
                      width: 90,
                      decoration: const BoxDecoration(
                        color: tWateringColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(35),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Row(
                      children: [
                        Container(
                          height: 34,
                          width: 34,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 18,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ],
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
