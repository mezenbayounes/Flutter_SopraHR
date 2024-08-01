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
////////////////
      List<dynamic> jsonResponse = json.decode(response.body);

      // Print the entire response body
      print('Response body: ${jsonResponse}');

      // Extract and print user_id from each item in the list
      for (var item in jsonResponse) {
        if (item is Map<String, dynamic> && item.containsKey('user_id')) {
          print('User ID: ${item['user_id']}');
        } else {
          print('User ID not found in item: $item');
        }
      }

      ///
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
              text: 'Congé', // Optional text label
            ),
            Tab(
              icon: Icon(Icons.tv_rounded),
              text: 'TT', // Optional text label
            ),
          ],
          indicatorColor:
              Color.fromARGB(255, 255, 0, 0), // Change indicator color
          labelColor:
              Color.fromARGB(255, 254, 7, 7), // Change selected tab label color
          unselectedLabelColor:
              Colors.grey, // Change unselected tab label color
        )),
        body: VerticalTabBarView(
          children: [
            _buildTabContentConge(context),
            _buildTabContent(context),
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
                const Text(
                  "Demande De Conge",
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
                const Text(
                  "TT",
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
