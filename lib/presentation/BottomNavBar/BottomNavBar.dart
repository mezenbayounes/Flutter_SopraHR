import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/utils/navigator_service.dart';
import 'package:sopraflutter/routes/app_routes.dart';

class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;
  String? role = "";
  setBottomBarIndex(index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
    setState(() {
      currentIndex = index;
      role = prefs.getString('role');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent.shade700,
              child: Icon(Icons.home_sharp),
              elevation: 0.1,
              onPressed: () {
                NavigatorService.pushNamed(
                  AppRoutes.homeScreenNews,
                );
              },
            ),
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.table_view_sharp,
                    color: currentIndex == 0
                        ? Colors.redAccent.shade700
                        : Colors.grey.shade400,
                  ),
                  onPressed: () {
                    setBottomBarIndex(0);
                    if (role == "admin") {
                      NavigatorService.pushNamed(
                        AppRoutes.homeADDAdmin,
                      );
                      print(role);
                    } else {
                      NavigatorService.pushNamed(
                        AppRoutes.homeADD,
                      );
                      print(role);
                    }
                  },
                  splashColor: Colors.white,
                ),
                Container(
                  width: size.width * 0.20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: currentIndex == 1
                        ? Colors.redAccent.shade700
                        : Colors.grey.shade400,
                  ),
                  onPressed: () {
                    setBottomBarIndex(1);
                    NavigatorService.pushNamed(
                      AppRoutes.profileScreen,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, const Color.fromARGB(255, 255, 252, 252), 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
