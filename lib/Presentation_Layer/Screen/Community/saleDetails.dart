import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/colors.dart';
import '../Plant/Forms/Utils.dart';

// Widget to display details of a sale post
class SaleDetails extends StatelessWidget {
  const SaleDetails({
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
    this.phoneNumber,
  }) : super(key: key);

  // Properties for post details
  final String? title;
  final String? content;
  final String? date;
  final String? user;
  final String? profileImage;
  final String? imageURL1;
  final String? imageURL2;
  final String? imageURL3;
  final String? imageURL4;
  final String? imageURL5;
  final String? phoneNumber;
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
            "Community / Sale plant",
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
                return buildContent();
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          height: 50,
          width: 380,
          child: FloatingActionButton(
            backgroundColor: tPrimaryActionColor,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Theme(
                    data: ThemeData(
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
                      title: Text(
                        'Phone number : $phoneNumber',
                        style: const TextStyle(
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
                          child: IconButton(
                            icon: const Icon(Icons.phone,
                                color: tPrimaryActionColor),
                            onPressed: () {
                              _makePhoneCall(phoneNumber!);
                            },
                            tooltip: 'Call',
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          width: 120,
                          child: IconButton(
                            icon: const Icon(Icons.message_rounded,
                                color: tPrimaryActionColor),
                            onPressed: () {
                              _launchInBrowser(
                                  'https://wa.me/+962$phoneNumber');
                            },
                            tooltip: 'Call',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Center(
              child: Text(
                "Show phone number",
                style: TextStyle(
                  color: tThirdTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ));
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
                      color: Colors.white,
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
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // Shimmer effect for post image
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
            color: Colors.white,
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
            color: Colors.white,
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
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Widget for displaying actual content
  Widget buildContent() {
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
          child: buildImageWidget(imageURL1),
        ),
        const SizedBox(
          height: 10.0,
        ),
        // Actual content for additional post images
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildImageContainer(imageURL2),
            buildImageContainer(imageURL3),
            buildImageContainer(imageURL4),
            buildImageContainer(imageURL5),
          ],
        ),
        const SizedBox(height: 10),
        // Actual content for post title
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
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
  Widget buildImageContainer(String? imageURL) {
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
      child: buildImageWidget(imageURL),
    );
  }

  // Build an image widget with or without an actual image URL
  Widget buildImageWidget(String? imageUrl) {
    if (imageUrl?.isNotEmpty ?? false) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
      );
    } else {
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
      );
    }
  }

  // Simulate fetching data after some delay
  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
