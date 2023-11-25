import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/colors.dart';
import '../Screen/CommunityScreen/createPost.dart';
import '../Screen/CommunityScreen/createSellplant.dart';

class ExpandWidget extends StatefulWidget {
  @override
  _ExpandWidgetState createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.up,
      children: [
        ElevatedButton(
          onPressed: toggleExpansion,
          style: ElevatedButton.styleFrom(
            backgroundColor: tPrimaryActionColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(19.0),
          ),
          child: Icon(
            isExpanded ? FontAwesomeIcons.xmark : FontAwesomeIcons.plus,
            size: 26.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        if (isExpanded) ...[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePost(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(55, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(55.0),
              ),
              backgroundColor: tPrimaryActionColor,
              padding: const EdgeInsets.all(10),
            ),
            child: const Icon(
              FontAwesomeIcons.newspaper,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateSellPlant(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(55, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(55.0),
              ),
              backgroundColor: tPrimaryActionColor,
              padding: const EdgeInsets.all(10),
            ),
            child: const Icon(
              FontAwesomeIcons.dollarSign,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}
