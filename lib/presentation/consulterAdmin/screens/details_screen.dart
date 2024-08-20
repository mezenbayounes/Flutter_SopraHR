import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/consulterAdmin/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:loading_btn/loading_btn.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(this.data, {Key? key}) : super(key: key);
  final LeaveData data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    String imageEtat = "";
    bool _isAcceptVisible = true;
    bool _isRefuseVisible = true;
    if (widget.data.etat == "EC") {
      imageEtat = "EC.png";
    } else if (widget.data.etat == "VALIDE") {
      imageEtat = "VALIDE.png";
      _isAcceptVisible = false;
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                thickness: 1, color: const Color.fromARGB(255, 176, 176, 176)),
            SizedBox(height: 8.0),
            buildRow(
              context,
              "date_debut".tr,
              DateFormat('dd/MM/yyyy').format(widget.data.dateDebut),
            ),
            SizedBox(height: 15.0),
            Divider(
                thickness: 1, color: const Color.fromARGB(255, 176, 176, 176)),
            SizedBox(height: 8.0),
            buildRow(
              context,
              "sc_debut".tr,
              widget.data.scDebut!,
            ),
            SizedBox(height: 15.0),
            Divider(
                thickness: 1, color: const Color.fromARGB(255, 176, 176, 176)),
            SizedBox(height: 8.0),
            buildRow(
              context,
              "date_fin".tr,
              DateFormat('dd/MM/yyyy').format(widget.data.dateFin),
            ),
            SizedBox(height: 15.0),
            Divider(
                thickness: 1, color: const Color.fromARGB(255, 176, 176, 176)),
            SizedBox(height: 8.0),
            buildRow(
              context,
              "sc_fin".tr,
              widget.data.scFin!,
            ),
            SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isAcceptVisible)
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: LoadingBtn(
                        height: 45,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: 10.0, // Reduced vertical padding
                        ),
                        borderRadius: 10,
                        animate: true,
                        color: const Color.fromARGB(255, 48, 133, 51),
                        width: MediaQuery.of(context).size.width * 0.43,
                        loader: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        child:  Text(
                          "confirme".tr,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (btnState == ButtonState.idle) {
                            startLoading();
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            Validate(widget.data.id);
                            stopLoading();
                          }
                        },
                      ),
                    ),
                  ),
                if (_isRefuseVisible)
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: LoadingBtn(
                        height: 45,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: 10.0, // Reduced vertical padding
                        ),
                        borderRadius: 10,
                        animate: true,
                        color: Color.fromARGB(255, 183, 3, 3),
                        width: MediaQuery.of(context).size.width * 0.43,
                        loader: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        child:  Text(
                          "refuse".tr,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (btnState == ButtonState.idle) {
                            startLoading();
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            Refuse(widget.data.id);
                            stopLoading();
                          }
                        },
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildRow(BuildContext context, String label, String value) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 162, 156, 156),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.4, // Use percentage of screen width
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end, // Align text to the end (right side)
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
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
