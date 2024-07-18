import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sopraflutter/localization/app_localization.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/presentation/News_page/components/breaking_news_card.dart';
import 'package:sopraflutter/presentation/News_page/components/news_list_tile.dart';
import 'package:sopraflutter/presentation/News_page/models/news_model.dart';
import 'package:sopraflutter/theme/theme_helper.dart';

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
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 2.0, color: Colors.black),
                            bottom: BorderSide(width: 2.0, color: Colors.black),
                          ),
                        ),
                        child: Text("Sopra Hr News",
                            style: theme.textTheme.titleLarge),
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
      bottomNavigationBar: Container(child: BottomNavBarV2()),
    );
  }
}
