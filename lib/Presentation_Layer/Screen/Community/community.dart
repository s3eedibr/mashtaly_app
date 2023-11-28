import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import 'Widget/expandedButton.dart';
import 'Widget/articleWidget.dart';
import 'Widget/sellPlantWidget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tBgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              color: Colors.white,
              height: 56,
              child: Row(
                children: [
                  // Search input field
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
                  // Filter icon button
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Row(
                      children: [
                        IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
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
            // Body content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {});
                  },
                  color: tPrimaryActionColor,
                  backgroundColor: tBgColor,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // UI for new articles
                        buildNewArticleUI(context),
                        // UI for articles
                        buildArticleUI(context),
                        // UI for new plants for sell
                        buildNewPlantsForSell(context),
                        // UI for plants for sell
                        buildPlantsForSellUI(context),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        // Floating Action Button
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ExpandWidget(),
      ),
    );
  }
}
