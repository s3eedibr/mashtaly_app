import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Constants/colors.dart';

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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
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
              return buildShimmerContent();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return buildContent();
            }
          },
        ),
      ),
    );
  }

  Widget buildShimmerContent() {
    return ListView(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 25.0,
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

  Widget buildContent() {
    return ListView(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 25.0,
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
        Text(
          date ?? "",
          style: TextStyle(
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          content ?? "",
          maxLines: 200,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

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

  Widget buildImageWidget(String? imageURL) {
    if (imageURL?.isNotEmpty ?? false) {
      return Image.network(
        imageURL!,
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

  Future<void> fetchData() async {
    // Simulate fetching data after some delay
    await Future.delayed(const Duration(seconds: 2));
  }
}
