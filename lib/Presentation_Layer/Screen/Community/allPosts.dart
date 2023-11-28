import 'package:flutter/material.dart';
import '../../../Constants/colors.dart';
import 'Data/getData.dart';
import 'Widget/appBar.dart';
import 'Widget/post_card3.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {});
          },
          color: tPrimaryActionColor,
          backgroundColor: tBgColor,
          child: FutureBuilder(
            future: getAllPostsList(),
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return PostCard3.buildShimmerCard();
                  },
                );
              } else if (snapshot.hasError) {
                // Handle error case
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // Display the posts using GridView.builder
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data![index];
                    return PostCard3(
                      imageURL: post['post_pic1'],
                      user: post['user'],
                      title: post['title'],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
