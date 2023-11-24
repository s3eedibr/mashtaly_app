import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<ConnectivityResult> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }

  Future<bool> isLoading() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return true;
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
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox(height: 10);
                    } else if (index == 1) {
                      return Expanded(child: buildNewArticleUI());
                    } else if (index == 2) {
                      return Expanded(child: buildArticleUI());
                    } else if (index == 3) {
                      return Expanded(child: buildNewPlantsForSell());
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
            if (isExpanded)
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
            if (isExpanded)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateSellplant(),
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
        ),
      ),
    );
  }

  Widget buildNewPlantsForSell() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New plants for sale',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellDetails(),
                    ),
                  );
                },
                child: FutureBuilder(
                  future: isLoading(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.data == null) {
                      return const ArticlesCard(isLoading: true);
                    } else {
                      return const ArticlesCard(isLoading: false);
                    }
                  },
                ),
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data == ConnectivityResult.none) {
                showSankBar(context, 'No internet connection.');
              }

              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collectionGroup('posts')
                    .where('posted', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  'See More',
                                  style: TextStyle(
                                    color: tPrimaryActionColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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
            'Plants for Sale',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        FutureBuilder(
          future: _checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == ConnectivityResult.none) {
              showSankBar(context, 'No internet connection.');
            }

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sellplant')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('SellPlant')
                  .where('posted', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
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

                return Flexible(
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
                                builder: (context) => const SellDetails(),
                              ),
                            );
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text(
                                'See More',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final post =
                            posts[index].data() as Map<String, dynamic>;
                        return ArticlesCard2(
                          title: post['title'],
                          imageURL: post['imageURL'],
                          user: post['user'],
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildNewArticleUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New Articles',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostDetails(),
                    ),
                  );
                },
                child: FutureBuilder(
                  future: isLoading(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.data == null) {
                      return const ArticlesCard(isLoading: true);
                    } else {
                      return const ArticlesCard(isLoading: false);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
