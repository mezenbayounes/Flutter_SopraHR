import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/constants/socket_service.dart';
import 'package:sopraflutter/localization/app_localization.dart';
import 'package:sopraflutter/main.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/presentation/News_page/components/breaking_news_card.dart';
import 'package:sopraflutter/presentation/News_page/components/news_list_tile.dart';
import 'package:sopraflutter/presentation/News_page/models/news_model.dart';
import 'package:sopraflutter/presentation/profile_screen/bloc/profile_bloc.dart';
import 'package:sopraflutter/theme/theme_helper.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static WidgetBuilder get builder => (BuildContext context) => HomeScreen();

  final SocketService socketService = SocketService(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? userId = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
    socketService.initSocket();

// Initialize the socket connection
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userID');
  }

  @override
  void dispose() {
    socketService.dispose(); // Dispose of the socket connection
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background Image with Opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.5, // Adjust opacity here (0.0 to 1.0)
              child: Image.asset(
                bg, // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical:
                                8.0), // Added vertical padding for better spacing
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.orange,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius:
                              BorderRadius.circular(30.0), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.6), // Darker shadow for more contrast
                              offset: Offset(0,
                                  6), // Slightly larger offset for a more pronounced shadow
                              blurRadius:
                                  30.0, // Increased blur radius for a softer shadow
                              spreadRadius:
                                  1.0, // Optional: add a slight spread for a fuller shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "Sopra Hr News",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors
                                .white, // Changed text color to white for better contrast
                            fontWeight:
                                FontWeight.bold, // Added bold font weight
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Breaking News",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container for Breaking News with shadow effect
                  CarouselSlider.builder(
                    itemCount: NewsData.breakingNewsData.length,
                    itemBuilder: (context, index, id) =>
                        BreakingNewsCard(NewsData.breakingNewsData[index]),
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                    ),
                  ),

                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Recent News",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  // Container for Recent News with shadow effect
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 214, 214, 214),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 4),
                          blurRadius: 50.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: NewsData.recentNewsData
                          .map((e) => NewsListTile(e))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(child: BottomNavBarV2(index: 0)),
    );
  }
}
