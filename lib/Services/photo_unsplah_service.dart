import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UnsplashPhotosScreen extends StatefulWidget {
  const UnsplashPhotosScreen({super.key});

  @override
  _UnsplashPhotosScreenState createState() => _UnsplashPhotosScreenState();
}

class _UnsplashPhotosScreenState extends State<UnsplashPhotosScreen> {
  List<String> photoUrls = [];

  Future<void> _fetchPhotos() async {
    const String url =
        'https://api.unsplash.com/search/photos?query=Aloe%20Vera&client_id=187eIB9xAk7cmtokC5xYlDc4E6IgAB7f1sm6LLLmfs0';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('No internet connection');
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final photos = data['results'];
        List<String> urls = [];
        for (var photo in photos) {
          urls.add(photo['urls']['regular']);
        }
        setState(() {
          photoUrls = urls;
        });
      } else {
        print('Failed to load photos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsplash Photos'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: photoUrls.length,
        itemBuilder: (context, index) {
          return Image.network(
            photoUrls[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
