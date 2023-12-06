import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import 'Widget/appBar.dart';
import 'Widget/expandedButton.dart';
import 'Widget/articleWidget.dart';
import 'Widget/salePlantWidget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBarWidget(
        title: 'Community',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      // UI for new plants for sale
                      buildNewPlantsForSale(context),
                      // UI for plants for sale
                      buildPlantsForSaleUI(context),
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
    );
  }
}
