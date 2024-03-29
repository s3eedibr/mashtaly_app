import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import '../Community/Data/getData.dart';
import '../Community/Widget/appBar.dart';
import '../Community/Widget/post_card3.dart';
import '../Community/postDetails.dart';

class ListMyPosts extends StatefulWidget {
  const ListMyPosts({Key? key}) : super(key: key);

  @override
  State<ListMyPosts> createState() => _ListMyPostsState();
}

class _ListMyPostsState extends State<ListMyPosts> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBarWidget(
        title: 'My article',
      ),
      body: buildPostList(),
    );
  }

  // Function to build the post list
  Widget buildPostList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        color: tPrimaryActionColor,
        backgroundColor: tBgColor,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          // Fetch all posts using the getMyPosts() function
          future: getMyPosts(FirebaseAuth.instance.currentUser!.uid),
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
                  id: post['id'],
                  userID: post['user_id'],
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
