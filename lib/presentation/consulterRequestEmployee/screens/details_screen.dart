import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/consulterRequestEmployee/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(this.data, {Key? key}) : super(key: key);
  final LeaveData data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
    bool _isAcceptVisible = false;
    bool _isRefuseVisible = false;

    if (widget.data.etat == "EC") {
      imageEtat = "EC.png";
    } else if (widget.data.etat == "VALIDE") {
      imageEtat = "VALIDE.png";
    } else if (widget.data.etat == "INVALIDE") {
      imageEtat = "INVALIDE.png";
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
              opacity: 0.6, // Adjust opacity as needed
              child: Image.asset(
                bg, // Background image from constants.dart
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
                          indent: 20,
                          endIndent: 20,
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
                          indent: 20,
                          endIndent: 20,
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
                        buildRow(
                          context,
                          "type_de_conge".tr,
                          widget.data.typeConge!,
                        ),
                        SizedBox(height: 15.0),
                        Divider(
                            thickness: 1,
                            color: const Color.fromARGB(255, 176, 176, 176)),
                        SizedBox(height: 8.0),
                        buildRow(
                          context,
                          "date_debut".tr,
                          DateFormat('dd/MM/yyyy').format(widget.data.dateDebut
                              .add(const Duration(days: 1))),
                        ),
                        SizedBox(height: 15.0),
                        Divider(
                            thickness: 1,
                            color: const Color.fromARGB(255, 176, 176, 176)),
                        SizedBox(height: 8.0),
                        buildRow(
                          context,
                          "sc_debut".tr,
                          widget.data.scDebut!,
                        ),
                        SizedBox(height: 15.0),
                        Divider(
                            thickness: 1,
                            color: const Color.fromARGB(255, 176, 176, 176)),
                        SizedBox(height: 8.0),
                        buildRow(
                          context,
                          "date_fin".tr,
                          DateFormat('dd/MM/yyyy').format(
                              widget.data.dateFin.add(const Duration(days: 1))),
                        ),
                        SizedBox(height: 15.0),
                        Divider(
                            thickness: 1,
                            color: const Color.fromARGB(255, 176, 176, 176)),
                        SizedBox(height: 8.0),
                        buildRow(
                          context,
                          "sc_fin".tr,
                          widget.data.scFin!,
                        ),
                        SizedBox(height: 15.0),
                        Divider(
                            thickness: 1,
                            color: const Color.fromARGB(255, 176, 176, 176)),
                        SizedBox(height: 8.0),
                        Center(
                          child: Text(
                            "Cause".tr,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 76, 76, 76),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 150.0,
                          ),
                          child: SizedBox(
                            width: screenWidth * 0.9,
                            child: Text(
                              widget.data.cause,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 112, 112, 112),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
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

  static Future<bool> Validate(int congeID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.put(
      Uri.parse('$baseUrl/conge/ValidateConge'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'congeId': congeID, 'etat': "VALIDE"}),
    );

    if (response.statusCode == 200) {
      NavigatorService.pushNamed(AppRoutes.homeScreenConsluterAdmin);
      return true;
    } else {
      print('Failed to validate: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  static Future<void> Refuse(int congeID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.put(
      Uri.parse('$baseUrl/conge/ValidateConge'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'congeId': congeID, 'etat': "INVALIDE"}),
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
