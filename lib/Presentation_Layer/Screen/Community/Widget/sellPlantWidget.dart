import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Community/allSells.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Community/sellDetails.dart';

import '../../../../Constants/colors.dart';
import 'post_card.dart';
import 'post_card2.dart';
import '../../../Widget/sankBar.dart';
import '../Data/getData.dart';

Widget buildNewPlantsForSell() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      const Text(
        'New plants for sell',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(
        height: 250,
        child: FutureBuilder(
          future: checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.data == ConnectivityResult.none) {
              showSnakBar(context, 'No internet connection.');
              return Container(); // Return an empty container when there is no internet connection
            }

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: getLatestSellPosts(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      PostCard.buildShimmerCard(),
                      PostCard.buildShimmerCard(),
                    ],
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final sells = snapshot.data;

                if (sells == null || sells.isEmpty) {
                  return const Center(
                    child: Text('No posts available.'),
                  );
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sells.length > 2
                        ? 2
                        : sells.length, // Adjusted itemCount
                    itemBuilder: (BuildContext context, index) {
                      final sell = sells[index];
                      return PostCard(
                        title: sell['title'],
                        imageURL: sell['sell_pic1'],
                        user: sell['user'],
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    ],
  );
}

Widget buildPlantsForSellUI(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Plants for sell',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListAllSells(),
                  ),
                );
              },
              child: const Text(
                'See more',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: tPrimaryActionColor,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 250,
        child: FutureBuilder(
          future: checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.data == ConnectivityResult.none) {
              showSnakBar(context, 'No internet connection.');
            }

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllSellPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      PostCard2.buildShimmerCard(),
                      PostCard2.buildShimmerCard(),
                    ],
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final sells = snapshot.data;

                if (sells == null || sells.isEmpty) {
                  return const Center(
                    child: Text('No posts available.'),
                  );
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: sells.length > 3
                        ? 3
                        : sells.length, // Adjusted itemCount
                    itemBuilder: (BuildContext context, index) {
                      if (index == sells.length) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SellDetails(),
                              ),
                            );
                          },
                        );
                      } else {
                        final sell = sells[index];
                        return PostCard2(
                          title: sell['title'],
                          imageURL: sell['sell_pic1'],
                          user: sell['user'],
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      const SizedBox(
        height: 50,
      ),
    ],
  );
}
