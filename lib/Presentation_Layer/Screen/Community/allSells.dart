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

  // Function to build the list of sell posts
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
          // Fetch all sell posts using the getAllSellsList() function
          future: getAllSellsList(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerList(); // Display shimmer loading animation while waiting for data
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.error
                  .toString()); // Display error message if an error occurs
            } else {
              return buildPostsListView(
                  snapshot.data!); // Build the sell posts list view
            }
          },
        ),
      ),
    );
  }

  // Function to build a shimmer loading list
  Widget buildShimmerList() {
    return ListView.builder(
      itemCount: 9,
      itemBuilder: (context, index) {
        return PostCard3
            .buildShimmerCard(); // Use a shimmer card widget to simulate loading
      },
    );
  }

  // Function to build an error widget
  Widget buildErrorWidget(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'), // Display an error message
    );
  }

  // Function to build the actual sell posts list view
  Widget buildPostsListView(List<Map<String, dynamic>> sells) {
    return ListView.builder(
      itemCount: sells.length,
      itemBuilder: (context, index) {
        final post = sells[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the sell post details screen when a sell post is tapped
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
