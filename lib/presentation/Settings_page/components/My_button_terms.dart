import 'package:flutter/material.dart';

class My_Button_terms extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String text;

  const My_Button_terms(
      {Key? key, required this.onTap, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        decoration:
            BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255)),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 160,
              ),
              child: Icon(
                icon,
                // You can adjust the size and style of the icon as desired
                size: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
