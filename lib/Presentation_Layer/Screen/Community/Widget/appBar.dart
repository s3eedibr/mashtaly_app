import 'package:flutter/material.dart';
import '../../../../Constants/colors.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  AppBarWidget({required this.title});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      elevation: 0, // No shadow
      title: isSearching
          ? SizedBox(
              height: 40,
              child: TextField(
                cursorColor: tPrimaryActionColor,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: tSearchBarColor,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 15,
                  ),
                ),
                onSubmitted: (value) {
                  // Handle search here
                },
              ),
            )
          : Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryTextColor, // Adjust text color
              ),
            ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
            });
          },
          icon: Icon(
            isSearching ? Icons.close : Icons.search_rounded,
            color: tSearchIconColor,
            size: 27,
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {
            // Handle filter button press
          },
          icon: const Icon(
            Icons.filter_list_rounded,
            color: tSearchIconColor,
            size: 27,
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
