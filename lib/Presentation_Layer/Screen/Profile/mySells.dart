import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Community/sellDetails.dart';

import '../../../Constants/colors.dart';
import '../Community/Data/getData.dart';
import '../Community/Widget/appBar.dart';
import '../Community/Widget/post_card3.dart';

class ListMySells extends StatefulWidget {
  const ListMySells({Key? key}) : super(key: key);

  @override
  State<ListMySells> createState() => _ListMySellsState();
}

class _ListMySellsState extends State<ListMySells> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBarWidget(
        title: 'My plant for sell',
      ),
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
          // Fetch all sell posts using the getMySells() function
          future: getMySells(FirebaseAuth.instance.currentUser!.uid),
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
        final sell = sells[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the sell post details screen when a sell post is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SellDetails(
                  profileImage: sell['profile_pic'],
                  user: sell['user'],
                  imageURL1: sell['sell_pic1'],
                  imageURL2: sell['sell_pic2'],
                  imageURL3: sell['sell_pic3'],
                  imageURL4: sell['sell_pic4'],
                  imageURL5: sell['sell_pic5'],
                  title: sell['title'],
                  date: sell['date'],
                  content: sell['content'],
                  phoneNumber: sell['phone_number'],
                ),
              ),
            );
          },
          child: PostCard3(
            imageURL: sell['sell_pic1'],
            user: sell['user'],
            title: sell['title'],
          ),
        );
      },
    );
  }
}
