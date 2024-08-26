import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/presentation/consulterAdmin/components/news_list_tile.dart';
import 'package:sopraflutter/presentation/consulterAdmin/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart'; // Add this import

class HomeScreenConsluterAdmin extends StatefulWidget {
  const HomeScreenConsluterAdmin({Key? key}) : super(key: key);
  static WidgetBuilder get builder =>
      (BuildContext context) => HomeScreenConsluterAdmin();

  @override
  State<HomeScreenConsluterAdmin> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenConsluterAdmin> {
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
      futureNewsData = fetchLeaveData(token ?? "", userId ?? 0);
    });
  }

// Function to fetch the username by user ID*

  // Function to fetch the username by user ID
  static Future<Map<String, String>> fetchUsername(
      String token, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/GetUserByID'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'id': userId}),
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);

        // Extract the username, image_url, and email from the nested 'user' object
        final username = userData['user']?['username'];
        final imageUrl = userData['user']?['image_url'];
        final email = userData['user']?['email'];

        if (username != null && imageUrl != null && email != null) {
          return {
            'username': username,
            'image_url': imageUrl,
            'email': email,
          };
        } else {
          throw Exception(
              'Username, image URL, or email not found in user data');
        }
      } else {
        final errorMessage =
            'Failed to load user data. Status code: ${response.statusCode}, Response: ${response.body}';
        print(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error fetching username, image URL, and email: $e');
      throw Exception(
          'Error fetching username, image URL, and email for User ID $userId');
    }
  }

  static Future<List<LeaveData>> fetchLeaveData(
      String token, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/conge/getCongesByManagerId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'id_manager': userId}),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      // Print the entire response body
      print('Response body: ${jsonResponse}');

      for (var item in jsonResponse) {
        if (item is Map<String, dynamic> && item.containsKey('user_id')) {
          print('User ID: ${item['user_id']}');

          try {
            // Fetch the username, image URL, and email for this user ID
            Map<String, String> userInfo =
                await fetchUsername(token, item['user_id']);
            print(
                'Username for User ID ${item['user_id']}: ${userInfo['username']}');
            print(
                'Image URL for User ID ${item['user_id']}: ${userInfo['image_url']}');
            print('Email for User ID ${item['user_id']}: ${userInfo['email']}');

            // Add the username, image URL, and email to the item
            item['username'] = userInfo['username'];
            item['image'] = userInfo['image_url'];
            item['email'] = userInfo['email'];
          } catch (e) {
            print(
                'Error fetching username, image URL, and email for User ID ${item['user_id']}: $e');
            // You can decide how to handle this error. For example, set default values or continue.
          }

          print('Username: ${item['username']}');
          print('Image URL: ${item['image']}');
          print('Email: ${item['email']}');
        } else {
          print('User ID not found in item: $item');
        }
      }

      return jsonResponse.map((data) => LeaveData.fromJson(data)).toList();
    } else {
      print('Failed to load leave data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load leave data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Set the number of tabs
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.holiday_village_outlined),
                text: 'conge'.tr, // Optional text label
              ),
              Tab(
                icon: Icon(Icons.tv_rounded),
                text: 'tt'.tr, // Optional text label
              ),
            ],
            indicatorColor:
                Color.fromARGB(255, 255, 0, 0), // Change indicator color
            labelColor: Color.fromARGB(
                255, 254, 7, 7), // Change selected tab label color
            unselectedLabelColor:
                Colors.grey, // Change unselected tab label color
          ),
        ),
        body: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.5, // Adjust opacity here (0.0 to 1.0)
                child: Image.asset(
                  bg, // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // TabBarView content
            TabBarView(
              children: [
                _buildTabContentConge(context),
                _buildTabContent(context),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBarV2(index: 1),
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
                Text(
                  "demande_de_conge".tr,
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
                      return const Center(child: Text('No news found'));
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
                  "demande_de_tt".tr,
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
                      return const Center(child: Text('No news found'));
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
