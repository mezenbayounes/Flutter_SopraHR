import 'package:flutter/material.dart';

class My_Button_Setting extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String text;

  const My_Button_Setting(
      {Key? key, required this.onTap, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 17,
              ),
            ),
            Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
