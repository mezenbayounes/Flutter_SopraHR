import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/localization/app_localization.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/presentation/News_page/components/breaking_news_card.dart';
import 'package:sopraflutter/presentation/News_page/components/news_list_tile.dart';
import 'package:sopraflutter/presentation/News_page/models/news_model.dart';
import 'package:sopraflutter/presentation/profile_screen/bloc/profile_bloc.dart';
import 'package:sopraflutter/theme/theme_helper.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static WidgetBuilder get builder => (BuildContext context) => HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical:
                                  8.0), // Added vertical padding for better spacing
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.redAccent,
                                Color.fromARGB(255, 140, 20, 17)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 10.0,
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
                    Column(
                      children: NewsData.recentNewsData
                          .map((e) => NewsListTile(e))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(child: BottomNavBarV2(index: 0)),
    );
  }
}
