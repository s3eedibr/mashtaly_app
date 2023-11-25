import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Authentication/forgotpassword_screen.dart';

import '../../../Constants/colors.dart';
import '../../Widget/articles_card.dart';
import '../../Widget/articles_card2.dart';
import 'createPost.dart';
import 'createSellplant.dart';
import 'postDetails.dart';
import 'sellDetails.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
  // Column buttonColumn = const CustomAddButton() as Column;

  Future<ConnectivityResult> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }

  Future<bool> isLoading() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return true;
  }

  Future<void> getAllPosts() async {
    final db = FirebaseFirestore.instance;

    final userUidsRef = db.collection('users');
    final getAllPostsRef = db.collection('getAllPosts');

    try {
      final userUidsSnapshot = await userUidsRef.get();

      for (final userDoc in userUidsSnapshot.docs) {
        final userId = userDoc.id;
        final userPostsRef =
            db.collection('posts').doc(userId).collection('Posts');

        final userPostsSnapshot =
            await userPostsRef.where('posted', isEqualTo: true).get();

        for (final postDoc in userPostsSnapshot.docs) {
          final postId = postDoc.id;
          final postData = postDoc.data();

          // Check if the "posted" flag is true before adding to getAllPosts
          if (postData['posted'] == true) {
            // Add the post to getAllPosts collection group
            await getAllPostsRef.doc(postId).set(postData);
            print('Post added to getAllPosts collection group: $postId');
          } else {
            print('Post skipped (not posted): $postId');
          }
        }
      }
    } catch (error) {
      print('Error creating getAllPosts collection group: $error');
    }
  }

  Future<void> getAllSells() async {
    final db = FirebaseFirestore.instance;

    final userUidsRef = db.collection('users');
    final getAllSellsRef = db.collection('getAllSells');

    try {
      final userUidsSnapshot = await userUidsRef.get();

      for (final userDoc in userUidsSnapshot.docs) {
        final userId = userDoc.id;
        final userPostsRef =
            db.collection('sellPlants').doc(userId).collection('SellPlants');

        final userSellsSnapshot =
            await userPostsRef.where('posted', isEqualTo: true).get();

        for (final postDoc in userSellsSnapshot.docs) {
          final postId = postDoc.id;
          final postData = postDoc.data();

          // Check if the "posted" flag is true before adding to getAllPosts
          if (postData['posted'] == true) {
            // Add the post to getAllPosts collection group
            await getAllSellsRef.doc(postId).set(postData);
            print('Post added to getAllSells collection group: $postId');
          } else {
            print('Post skipped (not posted): $postId');
          }
        }
      }
    } catch (error) {
      print('Error creating getAllPosts collection group: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: tBgColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                height: 56,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                        left: 16,
                        top: 2,
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 336,
                        child: TextField(
                          cursorColor: tPrimaryActionColor,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: tSearchBarColor,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 15,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: tSearchIconColor,
                              size: 27,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.filter_list_rounded,
                              color: tSearchIconColor,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Expanded(child: buildNewArticleUI());
                      } else if (index == 1) {
                        return Expanded(child: buildArticleUI());
                      } else if (index == 2) {
                        return Expanded(child: buildNewPlantsForSell());
                      } else if (index == 3) {
                        return Expanded(child: buildPlantsForSellUI());
                      } else {
                        return const SizedBox(height: 50);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.up,
            children: [
              ElevatedButton(
                onPressed: () {
                  toggleExpansion();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tPrimaryActionColor,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(19.0),
                ),
                child: Icon(
                  isExpanded ? FontAwesomeIcons.xmark : FontAwesomeIcons.plus,
                  size: 26.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              if (isExpanded) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreatePost(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(55, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55.0),
                    ),
                    backgroundColor: tPrimaryActionColor,
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.newspaper,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateSellPlant(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(55, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55.0),
                    ),
                    backgroundColor: tPrimaryActionColor,
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.dollarSign,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          )),
    );
  }

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
            future: _checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.data == ConnectivityResult.none) {
                showSankBar(context, 'No internet connection.');
              }

              return FutureBuilder(
                future: getAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ArticlesCard.buildShimmerCard();
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('getAllPosts')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ArticlesCard.buildShimmerCard();
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
            future: _checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.data == ConnectivityResult.none) {
                showSankBar(context, 'No internet connection.');
              }

              return FutureBuilder(
                future: getAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ArticlesCard2.buildShimmerCard();
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('getAllPosts')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ArticlesCard2.buildShimmerCard();
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
            future: _checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.data == ConnectivityResult.none) {
                showSankBar(context, 'No internet connection.');
              }

              return FutureBuilder(
                future: getAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ArticlesCard.buildShimmerCard();
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('getAllPosts')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ArticlesCard.buildShimmerCard();
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

  Widget buildPlantsForSellUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Text(
            'Plants for sell',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: FutureBuilder(
            future: _checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.data == ConnectivityResult.none) {
                showSankBar(context, 'No internet connection.');
              }

              return FutureBuilder(
                future: getAllSells(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ArticlesCard2.buildShimmerCard();
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('getAllSells')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ArticlesCard2.buildShimmerCard();
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      final sells = snapshot.data?.docs;

                      if (sells == null || sells.isEmpty) {
                        return const Center(
                          child: Text('No posts available.'),
                        );
                      }

                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: sells.length + 1,
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
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: sells.length > 3
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
                                  sells[index].data() as Map<String, dynamic>;
                              return ArticlesCard2(
                                title: post['title'],
                                imageURL: post['sell_pic1'],
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
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
