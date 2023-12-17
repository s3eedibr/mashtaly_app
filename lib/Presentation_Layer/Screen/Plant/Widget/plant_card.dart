// ignore_for_file: public_member_api_docs, sort_constructors_first
// Update PlantCard to use the loaded data
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:mashtaly_app/Constants/assets.dart';

import '../../../../Constants/colors.dart';
import '../Data/getData.dart';

class PlantCard extends StatefulWidget {
  final String? id;
  final String? plantName;
  final String? status;
  final String? imageURL;
  final List<List<dynamic>>? firstWatering;
  final bool? active;
  final String? user_id;
  const PlantCard({
    Key? key,
    this.plantName,
    this.status,
    this.imageURL,
    this.firstWatering,
    this.active,
    this.id,
    this.user_id,
  }) : super(key: key);

  @override
  State<PlantCard> createState() => _PlantCardState();

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
                      height: 40,
                      width: 90,
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

class _PlantCardState extends State<PlantCard> {
  bool isDelayed = false;
  String statusText = '';

  @override
  Widget build(BuildContext context) {
    return _buildContentCard(
      imageFile: widget.imageURL!,
      plantName: widget.plantName!,
      id: widget.id,
      userId: widget.user_id,
    );
  }

  Widget _buildContentCard({
    required String plantName,
    required String imageFile,
    String? id,
    String? userId,
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
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 120,
                              width: 180,
                              decoration: const BoxDecoration(
                                color: Colors.white,
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
                  // widget.active == true
                  FutureBuilder<List<List<dynamic>>>(
                    future: fetchWeatherConditionAndDuration(
                        myId: id!, userId: userId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              ),
                            ),
                            const SizedBox(
                              height: 5,
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
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        if (widget.active == true) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 90,
                                decoration: const BoxDecoration(
                                  color: tDelayedColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Check',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    Assets.assetsImagesIconsGroup201,
                                    height: 34,
                                    width: 34,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Check every 2hr',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: tDelayedTextColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
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
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    Assets.assetsImagesIconsGroup201,
                                    height: 34,
                                    width: 34,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Check every 2hr',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: tDelayedTextColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      } else {
                        List<List<dynamic>> weatherConditions = snapshot.data!;

                        String closestTime =
                            calculateClosestDisplayTime(weatherConditions);
                        if (widget.active == true) {
                          if (closestTime == 'Now') {
                            isDelayed = false;
                            statusText = 'Delayed';
                          } else {
                            isDelayed = true;
                            statusText = 'Watering';
                          }
                        } else {
                          statusText = 'Off';
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                color: widget.active == true
                                    ? isDelayed
                                        ? tWateringColor
                                        : tDelayedColor
                                    : tDelayedTextColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(35),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  statusText,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                widget.active == true
                                    ? isDelayed
                                        ? Image.asset(
                                            Assets.assetsImagesIconsGroup200,
                                            height: 34,
                                            width: 34,
                                          )
                                        : Image.asset(
                                            Assets.assetsImagesIconsGroup201,
                                            height: 34,
                                            width: 34,
                                          )
                                    : Image.asset(
                                        Assets.assetsImagesIconsGroup201,
                                        height: 34,
                                        width: 34,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    closestTime,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: widget.active == true
                                          ? isDelayed
                                              ? tWateringColor
                                              : tDelayedTextColor
                                          : tDelayedTextColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String calculateClosestDisplayTime(List<List<dynamic>> weatherConditions) {
  DateTime currentDateTimeObj = DateTime.now();
  DateTime closestTime = currentDateTimeObj;
  double minTimeDifference = double.infinity;

  for (var condition in weatherConditions) {
    // String weatherCondition = condition[0];
    int delayDay = condition[1];
    int delayHour = condition[2];
    int delayMinute = condition[3];

    DateTime displayTime = currentDateTimeObj
        .add(Duration(days: delayDay, hours: delayHour, minutes: delayMinute));
    double timeDifference =
        (displayTime.difference(currentDateTimeObj)).inMinutes.toDouble();

    if (timeDifference < minTimeDifference) {
      minTimeDifference = timeDifference;
      closestTime = displayTime;
    }
  }

  Duration timeDifference = closestTime.difference(currentDateTimeObj);

  if (timeDifference.inMinutes <= 0) {
    return 'Now'; // Display 'Now' if the time difference is equal to or less than 0
  }

  String formattedTimeDifference = '';

  if (timeDifference.inDays > 0) {
    formattedTimeDifference += '${timeDifference.inDays} days ';
  }

  if (timeDifference.inHours > 0) {
    formattedTimeDifference += '${timeDifference.inHours % 24}hr ';
  }

  if (timeDifference.inMinutes > 0) {
    formattedTimeDifference += '${timeDifference.inMinutes % 60}min';
  }

  // return 'Delayed: $formattedTimeDifference, Next Time: ${closestTime.toLocal()}';
  return formattedTimeDifference.isNotEmpty
      ? formattedTimeDifference
      : 'Now'; // Display 'Now' if the time difference is less than a minute
}
