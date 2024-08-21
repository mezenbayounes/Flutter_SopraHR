import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/consulterAdmin/models/news_model.dart';
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
            // User has scrolled to the bottom
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
      body: Column(
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
                      offset: Offset(0, 4), // changes position of shadow
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
                      DateFormat('dd/MM/yyyy').format(widget.data.dateDebut),
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
                      DateFormat('dd/MM/yyyy').format(widget.data.dateFin),
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
                        maxHeight: 150.0, // Set a max height for the text
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
                    if (!_showShadow) SizedBox(height: 50.0),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 5, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isAcceptVisible)
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: PrettyCapsuleButton(
                          bgColor: Color.fromARGB(255, 9, 110, 0),
                          label: 'confirme'.tr,
                          labelStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                          onPressed: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            Validate(widget.data.id);
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
                          bgColor: Color.fromARGB(255, 147, 1, 1),
                          label: 'refuse'.tr,
                          labelStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                          onPressed: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            Refuse(widget.data.id);
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
              fontSize: 20.0,
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
              fontSize: 18.0,
              color: Color.fromARGB(255, 112, 112, 112),
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  static Future<void> Validate(int congeID) async {
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

      print("tvalidet");
    } else {
      print('Failed to validate: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to validate');
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

      print("tvalidet");
    } else {
      print('Failed to validate: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to validate');
    }
  }
}
