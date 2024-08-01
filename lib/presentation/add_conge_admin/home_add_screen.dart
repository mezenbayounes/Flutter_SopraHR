import 'package:flutter/material.dart';
import 'package:sopraflutter/core/utils/navigator_service.dart';
import 'package:sopraflutter/localization/app_localization.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
import 'package:sopraflutter/routes/app_routes.dart';
import 'package:sopraflutter/theme/theme_helper.dart';

class homeAddAdmin extends StatefulWidget {
  static WidgetBuilder get builder => (BuildContext context) => homeAddAdmin();

  @override
  _homeAddState createState() => _homeAddState();
}

class _homeAddState extends State<homeAddAdmin> {
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
    double screenheight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 0.6;
    double buttonHeight = screenheight * 0.2;
    double fontSize = screenWidth * 0.05;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 170),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  NavigatorService.pushNamed(
                      AppRoutes.lailyfaFebrinaCardScreen);
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
                  NavigatorService.pushNamed(
                      AppRoutes.homeScreenConsluterAdmin);
                },
                child: Container(
                    width: buttonWidth, // Set responsive width
                    height: buttonHeight, // Set responsive height
                    child: Image.asset('assets/images/validation.png')),
              ),
              SizedBox(height: 10),
              Text("consulter_les_tt".tr, style: theme.textTheme.titleMedium),
            ],
          ),
        ), // Set responsive font size

        SizedBox(height: 300),
      ],
    );
  }
}
