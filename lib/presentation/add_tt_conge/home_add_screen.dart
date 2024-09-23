import 'package:flutter/material.dart';
import 'package:sopraflutter/core/utils/navigator_service.dart';
import 'package:sopraflutter/localization/app_localization.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/routes/app_routes.dart';
import 'package:sopraflutter/theme/theme_helper.dart';
import 'package:sopraflutter/core/constants/constants.dart';

class homeAdd extends StatefulWidget {
  static WidgetBuilder get builder => (BuildContext context) => homeAdd();

  @override
  _homeAddState createState() => _homeAddState();
}

class _homeAddState extends State<homeAdd> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.6, // Adjust opacity as needed
                child: Image.asset(
                  bg, // Use the bg variable from constants.dart
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            // Main content
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator(); // Prevent scrolling
                return true;
              },
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: homeAddContent(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(child: BottomNavBarV2(index: 1)),
      ),
    );
  }
}

class homeAddContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 0.6;
    double buttonHeight = screenHeight * 0.16;
    double fontSize = screenWidth * 0.05;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.1),
        Center(
          child: Column(
            children: [
              Container(
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 193, 192, 192).withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: ElevatedButton(
                  onPressed: () {
                    NavigatorService.pushNamed(AppRoutes.addCongeScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // Transparent background
                    shadowColor: Colors.transparent, // Disable default shadow
                    padding: EdgeInsets.zero, // Remove default padding
                  ),
                  child: Image.asset('assets/images/demande_conge.png'),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "demande_de_conge".tr,
                style:
                    theme.textTheme.titleMedium?.copyWith(fontSize: fontSize),
              ),
              SizedBox(height: 60),
              Container(
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 193, 192, 192).withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    NavigatorService.pushNamed(
                        AppRoutes.homeScreenConsulterRequestEmployee);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Image.asset('assets/images/validation.png'),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "consulter_les_tt".tr,
                style:
                    theme.textTheme.titleMedium?.copyWith(fontSize: fontSize),
              ),
              SizedBox(height: 60),
              Container(
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 193, 192, 192).withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    NavigatorService.pushNamed(AppRoutes.addTTScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Image.asset('assets/images/remote.png'),
                ),
              ),
              SizedBox(height: 10),
              Text("demande_de_tt".tr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: fontSize,
                  )),
            ],
          ),
        ),
        SizedBox(height: 600),
      ],
    );
  }
}
