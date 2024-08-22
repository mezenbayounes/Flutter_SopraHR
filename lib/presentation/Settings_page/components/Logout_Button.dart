import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/utils/navigator_service.dart';
import 'package:sopraflutter/routes/app_routes.dart';

class LogOutButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String text;

  const LogOutButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
  }) : super(key: key);

  Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Prevents dismissing by pressing back
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 8.0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(
                        0, 5), // Changes the position of the shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 50.0,
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    'Are you sure?',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Do you really want to log out?',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 111, 120, 127),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool? confirmLogout = await _showConfirmationDialog(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (confirmLogout == true) {
          // Clear saved data

          await prefs.remove('token');
          await prefs.remove('userID');
          await prefs.remove('username');
          await prefs.remove('email');
          await prefs.remove('image_url');
          await prefs.remove('role');
          await prefs.remove('isLoggedIn');

          // Navigate to the login screen and remove all previous routes
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.loginScreen,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        decoration:
            const BoxDecoration(color: Color.fromARGB(108, 255, 255, 255)),
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
