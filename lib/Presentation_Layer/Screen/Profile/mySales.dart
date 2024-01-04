import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Community/saleDetails.dart';

import '../../../Constants/colors.dart';
import '../Community/Data/getData.dart';
import '../Community/Widget/appBar.dart';
import '../Community/Widget/post_card3.dart';

class ListMySales extends StatefulWidget {
  const ListMySales({Key? key}) : super(key: key);

  @override
  State<ListMySales> createState() => _ListMySalesState();
}

class _ListMySalesState extends State<ListMySales> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBarWidget(
        title: 'My plant for sale',
      ),
      body: buildSalesList(),
    );
  }

  // Function to build the list of sale posts
  Widget buildSalesList() {
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
          // Fetch all sale posts using the getMySales() function
          future: getMySales(FirebaseAuth.instance.currentUser!.uid),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerList(); // Display shimmer loading animation while waiting for data
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.error
                  .toString()); // Display error message if an error occurs
            } else {
              return buildPostsListView(
                  snapshot.data!); // Build the sale posts list view
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

  // Function to build the actual sale posts list view
  Widget buildPostsListView(List<Map<String, dynamic>> sales) {
    return ListView.builder(
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final sale = sales[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the sale post details screen when a sale post is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SaleDetails(
                  profileImage: sale['profile_pic'],
                  user: sale['user'],
                  id: sale['id'],
                  userID: sale['user_id'],
                  imageURL1: sale['sale_pic1'],
                  imageURL2: sale['sale_pic2'],
                  imageURL3: sale['sale_pic3'],
                  imageURL4: sale['sale_pic4'],
                  imageURL5: sale['sale_pic5'],
                  title: sale['title'],
                  date: sale['date'],
                  content: sale['content'],
                  phoneNumber: sale['phone_number'],
                ),
              ),
            );
          },
          child: PostCard3(
            imageURL: sale['sale_pic1'],
            user: sale['user'],
            title: sale['title'],
          ),
        );
      },
    );
  }
}
