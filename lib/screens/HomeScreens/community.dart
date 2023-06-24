import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      body: Center(
        child: Text(
          "Community",
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }
}
