import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/presentation/notification_page/components/news_list_tile.dart';
import 'package:sopraflutter/presentation/notification_page/models/news_model.dart';

import 'dart:convert';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart'; // Add this import

class NotificationScreenPage extends StatefulWidget {
  const NotificationScreenPage({Key? key}) : super(key: key);
  static WidgetBuilder get builder =>
      (BuildContext context) => NotificationScreenPage();

  @override
  State<NotificationScreenPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NotificationScreenPage> {
  Future<List<LeaveData>>? futureNewsData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('userID');
    setState(() {
      futureNewsData = fetchLeaveData(token ?? "", userId ?? 0, context);
    });
  }

// Function to fetch the username by user ID*

  // Function to fetch the username by user ID

  static Future<List<LeaveData>> fetchLeaveData(
      String token, int userId, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/notification/getNotificationByUserId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'user_id': userId}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // Print the entire response body
        print('Response body: ${jsonResponse}');

        if (jsonResponse.isEmpty) {
          // Show a dialog if there is no leave data
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('No notification'),
                content: Text('There is no notification'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          return []; // Return an empty list
        }

        for (var item in jsonResponse) {
          if (item is Map<String, dynamic> && item.containsKey('user_id')) {
            print('User ID: ${item['user_id']}');
          } else {
            print('User ID not found in item: $item');
          }
        }

        return jsonResponse.map((data) => LeaveData.fromJson(data)).toList();
      } else {
        // Show a dialog if the status code indicates an error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('There is no notification'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return []; // Return an empty list
      }
    } catch (e) {
      // Show a dialog if an unexpected error occurs
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An unexpected error occurred'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return []; // Return an empty list
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, // Set the number of tabs
      child: Scaffold(
        body: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.6, // Adjust opacity as needed
                child: Image.asset(
                  bg, // Use the bg variable from constants.dart
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            // Main content (VerticalTabBarView)
            VerticalTabBarView(
              children: [
                _buildTabContentConge(context),
                //_buildTabContent(context),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBarV2(index: 2),
      ),
    );
  }

  Widget _buildTabContentConge(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Notifications".tr,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                FutureBuilder<List<LeaveData>>(
                  future: futureNewsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No notifications found'));
                    } else {
                      return Column(
                        children: snapshot.data!
                            .map((leaveData) => NewsListTile(leaveData))
                            .toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notifications".tr,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                FutureBuilder<List<LeaveData>>(
                  future: futureNewsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No notifications found'));
                    } else {
                      return Column(
                        children: snapshot.data!
                            .map((leaveData) => NewsListTile(leaveData))
                            .toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
