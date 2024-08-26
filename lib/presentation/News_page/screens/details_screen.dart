//now let's for the details screen

import 'package:flutter/material.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/News_page/models/news_model.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(this.data, {Key? key}) : super(key: key);
  NewsData data;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 225, 225, 225),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
      ),
      body: Stack(
        children: [
          // Background image with opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.5, // Adjust opacity as needed
              child: Image.asset(
                bg, // Background image path from constants.dart
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.title!,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 61, 61,
                        61), // Adjust text color for better readability
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  widget.data.author!,
                  style: TextStyle(
                    color: Color.fromARGB(179, 0, 0,
                        0), // Adjust text color for better readability
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Hero(
                  tag: "${widget.data.title}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(widget.data.urlToImage!),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  widget.data.content!,
                  style: TextStyle(
                    color: Colors
                        .black, // Adjust text color for better readability
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
