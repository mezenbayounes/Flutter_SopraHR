import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/consulterRequestEmployee/models/news_model.dart';
import 'package:sopraflutter/presentation/consulterRequestEmployee/screens/details_screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/presentation/consulterRequestEmployee/screens/details_screen_remote.dart';
import 'package:sopraflutter/theme/theme_helper.dart';

class NewsListTile2 extends StatefulWidget {
  final RemoteData data;

  NewsListTile2(this.data, {Key? key}) : super(key: key);

  @override
  State<NewsListTile2> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile2> {
  @override
  Widget build(BuildContext context) {
    // Determine which image to show based on the state
    String imageEtat = "";
    Color colorWidget = Color.fromARGB(255, 255, 255, 255);
    Color colorEC = Color.fromARGB(255, 234, 233, 233);
    if (widget.data.etat == "EC") {
      imageEtat = "EC.png";
      colorWidget = colorEC;
    } else if (widget.data.etat == "VALIDE") {
      imageEtat = "VALIDE.png";
    } else if (widget.data.etat == "INVALIDE") {
      imageEtat = "INVALIDE.png";
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen_remote(widget.data),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20.0),
            padding: const EdgeInsets.all(12.0),
            height: 130,
            decoration: BoxDecoration(
              color: colorWidget,
              borderRadius: BorderRadius.circular(26.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Hero(
                    tag: "${widget.data.id}",
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150.0),
                        image: DecorationImage(
                          image: NetworkImage('$baseUrl/${widget.data.image}'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.username ?? "",
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 13.0),
                      Text(
                        "Remote Date:" ?? "",
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        DateFormat('dd/MM/yyyy').format(widget.data.remoteDate
                            .add(const Duration(days: 1))),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.data.created_at),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            right: 10,
            child: SizedBox(
              width: 30.0, // Set the width of the image
              height: 30.0, // Set the height of the image
              child: Image.network(
                '$baseUrl/assets/$imageEtat', // Path to your image asset
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
