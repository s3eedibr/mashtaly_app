import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import 'Data/getData.dart';
import 'Widget/appBar.dart';
import 'Widget/post_card3.dart';
import 'postDetails.dart';

class ListAllPosts extends StatefulWidget {
  const ListAllPosts({Key? key}) : super(key: key);

  @override
  State<ListAllPosts> createState() => _ListAllPostsState();
}

class _ListAllPostsState extends State<ListAllPosts> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBarWidget(),
      body: buildPostList(),
    );
  }

  // Function to build the post list
  Widget buildPostList() {
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
          // Fetch all posts using the getAllPostsList() function
          future: getAllPostsList(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerList(); // Display shimmer loading animation while waiting for data
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.error
                  .toString()); // Display error message if an error occurs
            } else {
              return buildPostsListView(
                  snapshot.data!); // Build the post list view
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

  // Function to build the actual post list view
  Widget buildPostsListView(List<Map<String, dynamic>> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the post details screen when a post is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetails(
                  profileImage: post['profile_pic'],
                  user: post['user'],
                  imageURL1: post['post_pic1'],
                  imageURL2: post['post_pic2'],
                  imageURL3: post['post_pic3'],
                  imageURL4: post['post_pic4'],
                  imageURL5: post['post_pic5'],
                  title: post['title'],
                  date: post['date'],
                  content: post['content'],
                ),
              ),
            );
          },
          child: PostCard3(
            imageURL: post['post_pic1'],
            user: post['user'],
            title: post['title'],
          ),
        );
      },
    );
  }
}
