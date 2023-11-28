import 'package:flutter/material.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Community/sellDetails.dart';

import '../../../Constants/colors.dart';
import 'Data/getData.dart';
import 'Widget/appBar.dart';
import 'Widget/post_card3.dart';

class ListAllSells extends StatefulWidget {
  const ListAllSells({Key? key}) : super(key: key);

  @override
  State<ListAllSells> createState() => _ListAllSellsState();
}

class _ListAllSellsState extends State<ListAllSells> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBarWidget(),
      body: buildSellsList(),
    );
  }

  Widget buildSellsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {});
        },
        color: tPrimaryActionColor,
        backgroundColor: tBgColor,
        child: FutureBuilder(
          future: getAllSellsList(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerList();
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.error.toString());
            } else {
              return buildPostsListView(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget buildShimmerList() {
    return ListView.builder(
      itemCount: 9,
      itemBuilder: (context, index) {
        return PostCard3.buildShimmerCard();
      },
    );
  }

  Widget buildErrorWidget(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'),
    );
  }

  Widget buildPostsListView(List<Map<String, dynamic>> sells) {
    return ListView.builder(
      itemCount: sells.length,
      itemBuilder: (context, index) {
        final post = sells[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SellDetails(
                  profileImage: post['profile_pic'],
                  user: post['user'],
                  imageURL1: post['sell_pic1'],
                  imageURL2: post['sell_pic2'],
                  imageURL3: post['sell_pic3'],
                  imageURL4: post['sell_pic4'],
                  imageURL5: post['sell_pic5'],
                  title: post['title'],
                  date: post['date'],
                  content: post['content'],
                ),
              ),
            );
          },
          child: PostCard3(
            imageURL: post['sell_pic1'],
            user: post['user'],
            title: post['title'],
          ),
        );
      },
    );
  }
}
