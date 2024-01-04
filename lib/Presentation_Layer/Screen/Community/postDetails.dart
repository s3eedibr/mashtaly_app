import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Community/editPost.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Constants/colors.dart';
import '../Plant/Forms/Utils.dart';

// Widget to display post details
class PostDetails extends StatelessWidget {
  const PostDetails({
    Key? key,
    this.title,
    this.content,
    this.date,
    this.user,
    this.profileImage,
    this.imageURL1,
    this.imageURL2,
    this.imageURL3,
    this.imageURL4,
    this.imageURL5,
    this.id,
    this.userID,
  }) : super(key: key);

  final String? title;
  final String? content;
  final String? date;
  final String? user;
  final String? id;
  final String? userID;
  final String? profileImage;
  final String? imageURL1;
  final String? imageURL2;
  final String? imageURL3;
  final String? imageURL4;
  final String? imageURL5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        // App bar configuration
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          // Back button
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        title: const Text(
          "Community / Post",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: FutureBuilder(
          // Simulating a future that returns data after some delay
          future:
              fetchData(), // Replace fetchData with your actual data fetching function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display shimmer content while waiting for data
              return buildShimmerContent();
            } else if (snapshot.hasError) {
              // Display error message if an error occurs
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Display actual content once data is available
              return buildContent(context, userID!, id!);
            }
          },
        ),
      ),
    );
  }

  // Widget for shimmer loading content
  Widget buildShimmerContent() {
    return ListView(
      children: [
        const SizedBox(
          height: 15,
        ),
        // Shimmer effect for user profile section
        Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(55),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 120,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),

        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 200,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShimmerImageContainer(),
            buildShimmerImageContainer(),
            buildShimmerImageContainer(),
            buildShimmerImageContainer(),
          ],
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 150,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 100,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: SizedBox(
            height: 100,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget for displaying actual content
  Widget buildContent(BuildContext context, String userID, String postID) {
    return ListView(
      children: [
        const SizedBox(
          height: 15,
        ),
        // Actual content for user profile section
        Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(profileImage ?? ""),
                ),
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              user ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // Actual content for post image
        Container(
          height: 200,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: buildImageWidget(context, imageURL1),
        ),
        const SizedBox(
          height: 10.0,
        ),
        // Actual content for additional post images
        imageURL4 == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imageURL2 != null
                      ? buildImageContainer(context, imageURL2)
                      : Container(),
                  imageURL3 != null
                      ? buildImageContainer(context, imageURL3)
                      : Container(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  imageURL2 != null
                      ? buildImageContainer(context, imageURL2)
                      : Container(),
                  imageURL3 != null
                      ? buildImageContainer(context, imageURL3)
                      : Container(),
                  imageURL4 != null
                      ? buildImageContainer(context, imageURL4)
                      : Container(),
                  imageURL5 != null
                      ? buildImageContainer(context, imageURL5)
                      : Container(),
                ],
              ),
        const SizedBox(height: 10),
        // Actual content for post title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            userID != FirebaseAuth.instance.currentUser!.uid
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.white,
                              titlePadding: const EdgeInsets.only(
                                right: 16,
                                bottom: 15,
                                left: 16,
                                top: 15,
                              ),
                              title: const Text(
                                'Are you sure to report this post?',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actionsPadding: const EdgeInsets.only(
                                right: 16,
                                bottom: 15,
                                left: 16,
                              ),
                              actions: [
                                SizedBox(
                                  height: 45,
                                  width: 120,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: tPrimaryActionColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await reportPost(userID, postID);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 120,
                                  child: OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        color: tThirdTextErrorColor,
                                        width: 1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        color: tThirdTextErrorColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 21,
                      width: 21,
                      decoration: const BoxDecoration(color: tBgColor),
                      child: const Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        size: 20,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.white,
                              titlePadding: const EdgeInsets.only(
                                right: 16,
                                bottom: 15,
                                left: 16,
                                top: 15,
                              ),
                              actionsPadding: const EdgeInsets.only(
                                right: 16,
                                bottom: 15,
                                left: 16,
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 150,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: tPrimaryActionColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          EditPost(
                                            postID: id,
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Edit post",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: 150,
                                      child: OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                            color: tThirdTextErrorColor,
                                            width: 1,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete post',
                                          style: TextStyle(
                                            color: tThirdTextErrorColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 21,
                      width: 21,
                      decoration: const BoxDecoration(color: tBgColor),
                      child: const Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        size: 20,
                      ),
                    ),
                  ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // Actual content for post date
        Text(
          Utils.getFormattedDateTimeSimple(date ?? ""),
          style: TextStyle(
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        // Actual content for post content
        Text(
          content ?? "",
          maxLines: 200,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Shimmer effect for image containers
  Widget buildShimmerImageContainer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 95,
        width: 85,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    );
  }

  // Build an image container with a shimmer effect
  Widget buildImageContainer(BuildContext context, String? imageURL) {
    return Container(
      height: 95,
      width: 85,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: buildImageWidget(context, imageURL),
    );
  }

  // Build an image widget with or without an actual image URL
  Widget buildImageWidget(BuildContext context, String? imageURL) {
    if (imageURL != null) {
      return GestureDetector(
        onTap: () {
          _showImageDialog(context, imageURL);
        },
        child: CachedNetworkImage(
          imageUrl: imageURL,
          fit: BoxFit.cover,
          placeholder: (BuildContext context, String url) => const Center(
              child: CircularProgressIndicator(
            color: tPrimaryActionColor,
          )),
          errorWidget: (BuildContext context, String url, dynamic error) =>
              const Center(
            child: Icon(Icons.image_not_supported_outlined),
          ),
        ),
      );
    } else {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 95,
          width: 85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      );
    }
  }

  // Simulate fetching data after some delay
  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

void _showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Image.network(imageUrl),
      );
    },
  );
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> reportPost(String userId, String postId) async {
  try {
    // Get the reference to the SalePlants collection for the specific user
    CollectionReference postsCollection =
        _firestore.collection('posts').doc(userId).collection('Posts');

    // Query for documents with the specified post ID
    QuerySnapshot querySnapshot =
        await postsCollection.where('id', isEqualTo: postId).get();

    // Iterate through the documents and update the 'report' field to true
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      await document.reference.update({'report': true});
    }

    print('Post reported successfully!');
  } catch (e) {
    print('Error reporting post: $e');
  }
}
