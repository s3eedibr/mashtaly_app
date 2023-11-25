import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';
import 'articles_card.dart';
import 'articles_card2.dart';
import '../../../Widget/sankBar.dart';
import '../Data/getData.dart';
import '../postDetails.dart';

Widget buildNewArticleUI() {
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
              showSankBar(context, 'No internet connection.');
            }

            return FutureBuilder(
              future: getAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ArticlesCard.buildShimmerCard(),
                      ArticlesCard.buildShimmerCard(),
                    ],
                  );
                }

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collectionGroup('getAllPosts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ArticlesCard.buildShimmerCard(),
                          ArticlesCard.buildShimmerCard(),
                        ],
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    final posts = snapshot.data?.docs;

                    if (posts == null || posts.isEmpty) {
                      return const Center(
                        child: Text('No posts available.'),
                      );
                    }

                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, index) {
                          if (index == posts.length) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PostDetails(),
                                  ),
                                );
                              },
                            );
                          } else {
                            final post =
                                posts[index].data() as Map<String, dynamic>;
                            return ArticlesCard(
                              title: post['title'],
                              imageURL: post['post_pic1'],
                              user: post['user'],
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ],
  );
}

Widget buildArticleUI() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: Text(
          'Articles',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(
        height: 250,
        child: FutureBuilder(
          future: checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.data == ConnectivityResult.none) {
              showSankBar(context, 'No internet connection.');
            }

            return FutureBuilder(
              future: getAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      ArticlesCard2.buildShimmerCard(),
                      ArticlesCard2.buildShimmerCard(),
                      ArticlesCard2.buildShimmerCard(),
                    ],
                  );
                }

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collectionGroup('getAllPosts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          ArticlesCard2.buildShimmerCard(),
                          ArticlesCard2.buildShimmerCard(),
                          ArticlesCard2.buildShimmerCard(),
                        ],
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    final posts = snapshot.data?.docs;

                    if (posts == null || posts.isEmpty) {
                      return const Center(
                        child: Text('No posts available.'),
                      );
                    }

                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: posts.length + 1,
                        itemBuilder: (BuildContext context, index) {
                          if (index == posts.length) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PostDetails(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child: posts.length > 3
                                      ? const Text(
                                          'See More',
                                          style: TextStyle(
                                            color: tPrimaryActionColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      : const Text(''),
                                ),
                              ),
                            );
                          } else {
                            final post =
                                posts[index].data() as Map<String, dynamic>;
                            return ArticlesCard2(
                              title: post['title'],
                              imageURL: post['post_pic1'],
                              user: post['user'],
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ],
  );
}
