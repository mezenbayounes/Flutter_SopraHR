import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/consulterAdmin/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // For date formatting if needed

class DetailsScreen_remote extends StatefulWidget {
  DetailsScreen_remote(this.data, {Key? key}) : super(key: key);
  final RemoteData data;

  @override
  State<DetailsScreen_remote> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen_remote> {
  late ScrollController _scrollController;
  bool _showShadow = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            setState(() {
              _showShadow = false;
            });
          } else {
            setState(() {
              _showShadow = true;
            });
          }
        } else {
          setState(() {
            _showShadow = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String imageEtat = "";
    bool _isAcceptVisible = true;
    bool _isRefuseVisible = true;

    // Determine the image based on the state
    if (widget.data.etat == "EC") {
      imageEtat = "EC.png";
    } else if (widget.data.etat == "VALIDE") {
      imageEtat = "VALIDE.png";
      _isAcceptVisible = false;
      _isRefuseVisible = false;
    } else if (widget.data.etat == "INVALIDE") {
      imageEtat = "INVALIDE.png";
      _isRefuseVisible = false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
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
          // Main content
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Hero(
                            tag: "${widget.data.id}",
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: screenWidth * 0.5,
                                width: screenWidth * 0.5,
                                child: Image.network(
                                  '$baseUrl/${widget.data.image}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Text(
                            widget.data.email,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 112, 112, 112),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                          indent: 40,
                          endIndent: 40,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.0),
                            image: DecorationImage(
                              image: NetworkImage('$baseUrl/assets/$imageEtat'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8.0),
                        Center(
                          child: Text(
                            "Remote Date ",
                            style: TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 76, 76, 76),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Center(
                          child: TableCalendar(
                            focusedDay: widget.data.remoteDate,
                            firstDay:
                                DateTime(2000), // Adjust the range as needed
                            lastDay: DateTime(2100),
                            // Keep the calendar fixed on the remote date
                            selectedDayPredicate: (day) {
                              return isSameDay(
                                  day,
                                  widget.data.remoteDate
                                      .add(const Duration(days: 1)));
                            },
                            // Remove onDaySelected to prevent changing the selected date
                            onDaySelected: null,
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color: Colors.orange[600],
                                shape: BoxShape.circle,
                              ),
                              outsideDaysVisible: false,
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible:
                                  false, // Hides the 2-week view toggle button
                              titleCentered: true, // Centers the header title
                              leftChevronVisible:
                                  true, // Hides the left navigation button
                              rightChevronVisible:
                                  true, // Hides the right navigation button
                            ),
                            availableCalendarFormats: const {
                              CalendarFormat.month:
                                  'Month', // Only shows the month format
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
                        if (!_showShadow) SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, top: 5, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isAcceptVisible)
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: PrettyCapsuleButton(
                              bgColor: Color.fromARGB(255, 99, 181, 93),
                              label: 'confirme'.tr,
                              labelStyle: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w900,
                              ),
                              onPressed: () async {
                                bool? shouldValidate =
                                    await _showConfirmationDialog(context);
                                if (shouldValidate == true) {
                                  bool success = await ValidateRemote(
                                      widget.data.id, widget.data.userId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(success
                                          ? 'Validation successful!'
                                          : 'Validation failed!'),
                                      backgroundColor:
                                          success ? Colors.green : Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      SizedBox(width: 10),
                      if (_isRefuseVisible)
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: PrettyCapsuleButton(
                              bgColor: Color.fromARGB(255, 212, 96, 67),
                              label: 'refuse'.tr,
                              labelStyle: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w900,
                              ),
                              onPressed: () async {
                                bool? shouldRefuse =
                                    await _showRefusalConfirmationDialog(
                                        context);
                                if (shouldRefuse == true) {
                                  try {
                                    await Refuse(widget.data.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Refusal successful!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Refusal failed!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRow(BuildContext context, String label, String value) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 76, 76, 76),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 17.5,
              color: Color.fromARGB(255, 112, 112, 112),
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5), // changes the position of the shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 50.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Are you sure?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Do you really want to validate this request?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool?> _showRefusalConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5), // changes the position of the shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 50.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Are you sure?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Do you really want to refuse this request?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              color: const Color.fromARGB(255, 231, 229, 229),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromARGB(255, 145, 145, 145),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> ValidateRemote(int remoteID, int userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.put(
      Uri.parse('$baseUrl/remote/validateRemoteRequest'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'userId': userID, 'remoteId': remoteID}),
    );

    if (response.statusCode == 200) {
      NavigatorService.pushNamed(AppRoutes.homeScreenConsluterAdmin);
      return true;
    } else {
      print('Failed to validate: ${response.statusCode}');
      print('Response body: ${response.body}');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = NavigatorService.navigatorKey.currentContext;
        if (context != null) {
          final responseBody = response.body;

// Parse the JSON response
          final Map<String, dynamic> responseData = jsonDecode(responseBody);

// Extract the error message
          final String errorMessage = responseData['error'];

// Display the error message using your `showErrorDialog` method
          showErrorDialog(context, errorMessage);
        }
      });
      return false;
    }
  }

  static Future<void> Refuse(int RemoteID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.put(
      Uri.parse('$baseUrl/remote/RefuseRemoteRequest'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'remoteId': RemoteID}),
    );

    if (response.statusCode == 200) {
      NavigatorService.pushNamed(AppRoutes.homeScreenConsluterAdmin);
      print("refused");
    } else {
      print('Failed to refuse: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to refuse');
    }
  }
}
