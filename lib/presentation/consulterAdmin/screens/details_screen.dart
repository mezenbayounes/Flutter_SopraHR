//now let's for the details screen

import 'package:flutter/material.dart';
import 'package:sopraflutter/core/constants/constants.dart';
import 'package:sopraflutter/presentation/consulterAdmin/models/news_model.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(this.data, {Key? key}) : super(key: key);
  LeaveData data;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.cause!,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.data.typeConge!,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Hero(
                tag: "${widget.data.id}",
                child: ClipRRect(
                  child: Image.network('$baseUrl/${widget.data.image}'),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              DateFormat('MM/dd/yyyy').format(widget.data.dateDebut),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            Text(widget.data.typeConge!)
          ],
        ),
      ),
    );
  }
}
