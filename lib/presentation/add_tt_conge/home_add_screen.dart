import 'package:flutter/material.dart';
import 'package:sopraflutter/core/utils/navigator_service.dart';
import 'package:sopraflutter/localization/app_localization.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/routes/app_routes.dart';
import 'package:sopraflutter/theme/theme_helper.dart';

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
        body: NotificationListener<OverscrollIndicatorNotification>(
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
        bottomNavigationBar: Container(child: BottomNavBarV2(index: 1)),
      ),
    );
  }
}

class homeAddContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8;
    double buttonHeight = screenWidth * 0.4;
    double fontSize = screenWidth * 0.05;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 200),
        ElevatedButton(
          onPressed: () {
            // Handle button 1 click event
            NavigatorService.pushNamed(AppRoutes.lailyfaFebrinaCardScreen);
          },
          child: Container(
              width: buttonWidth, // Set responsive width
              height: buttonHeight, // Set responsive height
              child: Image.asset('assets/images/demande_conge.png')),
        ),
        SizedBox(height: 10),
        Text("demande_de_conge".tr,
            style: theme.textTheme.titleMedium // Set responsive font size
            ),
        SizedBox(height: 60),
        ElevatedButton(
          onPressed: () {
            // Handle button 2 click event
            print('Button 2 clicked');
          },
          child: Container(
              width: buttonWidth, // Set responsive width
              height: buttonHeight, // Set responsive height
              child: Image.asset('assets/images/remote.png')),
        ),
        SizedBox(height: 10),
        Text("demande_de_tt".tr,
            style: theme.textTheme.titleMedium), // Set responsive font size

        SizedBox(height: 300),
      ],
    );
  }
}
