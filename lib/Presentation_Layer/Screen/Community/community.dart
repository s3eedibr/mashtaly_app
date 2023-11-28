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
                        buildNewArticleUI(context),
                        buildArticleUI(context),
                        buildNewPlantsForSell(context),
                        buildPlantsForSellUI(context),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ExpandWidget(),
      ),
    );
  }
}
