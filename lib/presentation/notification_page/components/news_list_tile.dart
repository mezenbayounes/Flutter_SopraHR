import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/notification_page/models/news_model.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/theme/theme_helper.dart';

class NewsListTile extends StatefulWidget {
  final LeaveData data;

  NewsListTile(this.data, {Key? key}) : super(key: key);

  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  @override
  Widget build(BuildContext context) {
    // Determine which image to show based on the state
    Color colorWidget = Color.fromARGB(255, 255, 255, 255);

    return InkWell(
      onTap: () {},
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
                          image: NetworkImage('$baseUrl/assets/EC.png'),
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
                        widget.data.type ?? "",
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 13.0),
                      Text(
                        widget.data.content ?? "",
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8.0),
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
                    fontSize: 11.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
