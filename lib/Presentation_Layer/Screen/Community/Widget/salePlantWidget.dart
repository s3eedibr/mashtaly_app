import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';
import '../../../Widget/snackBar.dart';
import '../Data/getData.dart';
import '../allSales.dart';
import '../saleDetails.dart';
import 'post_card.dart';
import 'post_card2.dart';

Widget buildNewPlantsForSale(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      const Text(
        'New plants for sale',
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
              showSnackBar(context, 'No internet connection.');
              return Container(); // Return an empty container when there is no internet connection
            }

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: getLatestSalePosts(),
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

                final sales = snapshot.data;

                if (sales == null || sales.isEmpty) {
                  return const Center(
                    child: Text('No posts available.'),
                  );
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sales.length > 2 ? 2 : sales.length,
                    itemBuilder: (BuildContext context, index) {
                      if (index < sales.length) {
                        final sale = sales[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaleDetails(
                                  profileImage: sale['profile_pic'],
                                  user: sale['user'],
                                  imageURL1: sale['sale_pic1'],
                                  imageURL2: sale['sale_pic2'],
                                  imageURL3: sale['sale_pic3'],
                                  imageURL4: sale['sale_pic4'],
                                  imageURL5: sale['sale_pic5'],
                                  title: sale['title'],
                                  date: sale['date'],
                                  content: sale['content'],
                                  phoneNumber: sale['phone_number'],
                                ),
                              ),
                            );
                          },
                          child: PostCard(
                            title: sale['title'],
                            imageURL: sale['sale_pic1'],
                            user: sale['user'],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
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

Widget buildPlantsForSaleUI(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Plants for sale',
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
                    builder: (context) => const ListAllSales(),
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
              showSnackBar(context, 'No internet connection.');
            }

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllSalesPosts(),
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

                final sales = snapshot.data;

                if (sales == null || sales.isEmpty) {
                  return const Center(
                    child: Text('No posts available.'),
                  );
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: sales.length > 2 ? 2 : sales.length,
                    itemBuilder: (BuildContext context, index) {
                      if (index < sales.length) {
                        final sale = sales[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaleDetails(
                                  profileImage: sale['profile_pic'],
                                  user: sale['user'],
                                  imageURL1: sale['sale_pic1'],
                                  imageURL2: sale['sale_pic2'],
                                  imageURL3: sale['sale_pic3'],
                                  imageURL4: sale['sale_pic4'],
                                  imageURL5: sale['sale_pic5'],
                                  title: sale['title'],
                                  date: sale['date'],
                                  content: sale['content'],
                                  phoneNumber: sale['phone_number'],
                                ),
                              ),
                            );
                          },
                          child: PostCard2(
                            title: sale['title'],
                            imageURL: sale['sale_pic1'],
                            user: sale['user'],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
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
