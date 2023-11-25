import 'package:flutter/material.dart';

import '../../../Constants/assets.dart';
import '../../../Constants/colors.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _CommunityState();
}

class _CommunityState extends State<PostDetails> {
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
          "Community",
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
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage(
                          Assets.assetsImagesIconsBell,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Name of user',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Image(
                  //     width: double.infinity,
                  //     height: 300.0,
                  //     image: NetworkImage(
                  //       'https://scontent.famm10-1.fna.fbcdn.net/v/t39.30808-6/347225219_982283046117731_3528217653228803303_n.jpg?stp=dst-jpg_p843x403&_nc_cat=108&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGN7teVU4kRnBbLSRFkbMKBuqzAYdutmAO6rMBh262YA-1zgyWoPoxJvedY7V-gB_Abn1PiWl7ZGZ3mBXY_Nbb0&_nc_ohc=6va5kvECAMoAX_kD1aV&_nc_oc=AQnr-sXbGNHa9mVJpXVl7xKm5A1WDy-DtKkuDOqlZuZM2fpei7u1hHz8Yufy1N1V_Ng&_nc_ht=scontent.famm10-1.fna&oh=00_AfCA_ayp9sXDjbFrH8R4blRlCfbprA1plfZN1Fo-eQ1roA&oe=6533C166',
                  //     )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'How to plant Tomatoes Properly without worry',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'December 21, 2023',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'test',
                    maxLines: 200,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}