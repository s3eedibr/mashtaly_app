import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_app/Presentation_Layer/Widget/sankBar.dart';

import '../../../../Constants/colors.dart';
import '../Data/getData.dart';
import '../allPosts.dart';
import '../postDetails.dart';
import 'post_card.dart';
import 'post_card2.dart';

Widget buildNewArticleUI(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      const Text(
        'New articles',
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
              future: getLatestPosts(),
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

                final posts = snapshot.data;

                if (posts == null || posts.isEmpty) {
                  return const Center(
                    child: Text('No posts available.'),
                  );
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: posts.length > 3 ? 3 : posts.length,
                    itemBuilder: (BuildContext context, index) {
                      if (index < posts.length) {
                        final post = posts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetails(
                                  profileImage: post['profile_pic'],
                                  user: post['user'],
                                  imageURL1: post['post_pic1'],
                                  imageURL2: post['post_pic2'],
                                  imageURL3: post['post_pic3'],
                                  imageURL4: post['post_pic4'],
                                  imageURL5: post['post_pic5'],
                                  title: post['title'],
                                  date: post['date'],
                                  content: post['content'],
                                ),
                              ),
                            );
                          },
                          child: PostCard(
                            title: post['title'],
                            imageURL: post['post_pic1'],
                            user: post['user'],
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

Widget buildArticleUI(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Articles',
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
                    builder: (context) => const ListAllPosts(),
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  PostCard2.buildShimmerCard(),
                  PostCard2.buildShimmerCard(),
                  PostCard2.buildShimmerCard(),
                ],
              );
            }

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllPosts(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      PostCard2.buildShimmerCard(),
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

                final posts = snapshot.data;

                if (posts == null || posts.isEmpty) {
                  return const Center(
                    child: Text('No posts available.'),
                  );
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: posts.length > 3 ? 3 : posts.length,
                    itemBuilder: (BuildContext context, index) {
                      if (index < posts.length) {
                        final post = posts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetails(
                                  profileImage: post['profile_pic'],
                                  user: post['user'],
                                  imageURL1: post['post_pic1'],
                                  imageURL2: post['post_pic2'],
                                  imageURL3: post['post_pic3'],
                                  imageURL4: post['post_pic4'],
                                  imageURL5: post['post_pic5'],
                                  title: post['title'],
                                  date: post['date'],
                                  content: post['content'],
                                ),
                              ),
                            );
                          },
                          child: PostCard2(
                            title: post['title'],
                            imageURL: post['post_pic1'],
                            user: post['user'],
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
