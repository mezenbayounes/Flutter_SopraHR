import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/utils/navigator_service.dart';
import 'package:sopraflutter/routes/app_routes.dart';

class LogOutButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String text;
  const LogOutButton(
      {Key? key, required this.onTap, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void saveData(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    }

    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Confirmation",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              content: const Text(
                "Are you sure you want to log out?",
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
                TextButton(
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  onPressed: () async {
                    Navigator.pop(context); // Close the dialog

                    saveData("token", "");
                    saveData("userID", "");
                    saveData("username", "");
                    saveData("email", "");
                    saveData("image_url", "");
                    saveData("role", "");

                    NavigatorService.pushNamed(
                      AppRoutes.loginScreen,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: Color.fromARGB(108, 255, 255, 255)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 231, 14, 14),
                fontSize: 17,
              ),
            ),
            Icon(
              icon,
              size: 25,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
