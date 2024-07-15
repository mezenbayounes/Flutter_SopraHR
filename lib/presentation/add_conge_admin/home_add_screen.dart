import 'package:flutter/material.dart';
import 'package:sopraflutter/localization/app_localization.dart';
import 'package:sopraflutter/presentation/BottomNavBar/BottomNavBar.dart';
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
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/bgme.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator(); // Prevent scrolling
              return true;
            },
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: homeAddContent(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class homeAddContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 190),
        ElevatedButton(
          onPressed: () {
            // Handle button 1 click event
            print('Button 1 clicked');
          },
          child: Container(
              width: 200, // Set desired width
              height: 200, // Set desired height
              child: Image.asset('assets/images/demande_conge.png')),
        ),
        SizedBox(height: 10),
        Text("demande_de_conge".tr, style: theme.textTheme.titleMedium),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            // Handle button 2 click event
            print('Button 2 clicked');
          },
          child: Container(
              width: 200, // Set desired width
              height: 200, // Set desired height
              child: Image.asset('assets/images/remote.png')),
        ),
        SizedBox(height: 10),
        Text("consulter_les_tt".tr, style: theme.textTheme.titleMedium),
        Container(
          height: 170, // Set a fixed height for the BottomNavBarV2
          child: BottomNavBarV2(),
        ),
      ],
    );
  }
}
