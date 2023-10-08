import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/colors.dart';
import '../../Models/articles_card.dart';
import '../../Models/articles_card2.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
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
                        // Wrap the ListView.builder with a Container
                        height: 250, // Set a fixed height or adjust as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, index) {
                            return const articlesCard();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                    // Wrap the ListView.builder with a Container
                    height: 250, // Set a fixed height or adjust as needed
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, index) {
                        if (index == 4) {
                          // Render the "See More" button as the last item
                          return GestureDetector(
                            onTap: () {
                              // Handle the "See More" button click
                            },
                            child: const Center(
                              child: Text(
                                'See More',
                                style: TextStyle(
                                    color: tPrimaryActionColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          );
                        } else {
                          return const articlesCard2();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
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
                        // Wrap the ListView.builder with a Container
                        height: 250, // Set a fixed height or adjust as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, index) {
                            return const articlesCard();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      'Plants for sale',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    // Wrap the ListView.builder with a Container
                    height: 250, // Set a fixed height or adjust as needed
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, index) {
                        if (index == 4) {
                          // Render the "See More" button as the last item
                          return GestureDetector(
                            onTap: () {
                              // Handle the "See More" button click
                            },
                            child: const Center(
                              child: Text(
                                'See More',
                                style: TextStyle(
                                    color: tPrimaryActionColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          );
                        } else {
                          return const articlesCard2();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Stack(
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
          Visibility(
            visible: isExpanded,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                const SizedBox(
                  height: 1,
                ),
                Positioned(
                  right: -16,
                  bottom: 7,
                  child: GestureDetector(
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: const BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(55),
                        ),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.newspaper,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: const BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(55),
                        ),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.dollarSign,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
