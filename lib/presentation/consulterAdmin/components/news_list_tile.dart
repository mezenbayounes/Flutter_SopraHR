import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/consulterAdmin/models/news_model.dart';
import 'package:sopraflutter/presentation/consulterAdmin/screens/details_screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class NewsListTile extends StatefulWidget {
  final LeaveData data;

  NewsListTile(this.data, {Key? key}) : super(key: key);

  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

 


class _NewsListTileState extends State<NewsListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(widget.data),
          ),
        );
      },
      
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.all(12.0),
        height: 130,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 251, 250, 250),
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
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          '$baseUrl/assets/image-1714051966264.jpg'),
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
                    widget.data.etat ?? 'No Title',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    DateFormat('MM/dd/yyyy').format(widget.data.dateDebut),
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
    );
  }
}
