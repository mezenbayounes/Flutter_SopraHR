import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/core/app_export.dart';
import 'package:sopraflutter/core/utils/navigator_service.dart';
import 'package:sopraflutter/routes/app_routes.dart';
import 'package:sopraflutter/theme/theme_helper.dart';

class BottomNavBarV2 extends StatefulWidget {
  final int index; // New parameter to pass the initial index
  BottomNavBarV2({Key? key, this.index = 0})
      : super(key: key); // Constructor with parameter

  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  late int currentIndex; // Current index of the selected tab
  String? role = ""; // User role, loaded from SharedPreferences
  final ScrollController _scrollController =
      ScrollController(); // Scroll controller for navigation bar

  _loadRole() async {
    // Load user role from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? ""; // Update role state
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRole();
    currentIndex = widget.index;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentIndex(); // Scroll to the selected tab when the widget builds
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll to make the selected GButton appear in the center
  void _scrollToCurrentIndex() {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth =
        screenWidth * 0.25; // Adjust tab width based on your design

    // Calculate the offset to scroll to, based on the current index
    double offset =
        (tabWidth * currentIndex) - (screenWidth / 2) + (tabWidth / 2);

    // Ensure the offset stays within scroll bounds
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.07;
    double textSize = screenWidth * 0.038; // Adjust the text size dynamically

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 18),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 228, 228),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.4),
          ),
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal, // Enables horizontal scrolling
          child: GNav(
            rippleColor: Colors.grey[800]!,
            hoverColor: Colors.grey[700]!,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
            ],
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 500),
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.red.shade700,
            iconSize: iconSize,
            tabBackgroundColor: Colors.red.withOpacity(0.1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
              _scrollToCurrentIndex(); // Scroll to the selected tab
            },
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'News',
                margin: EdgeInsets.symmetric(horizontal: 7),
                textStyle: (theme.textTheme.titleMedium?.copyWith(
                    fontSize: textSize,
                    color: const Color.fromARGB(255, 103, 102, 102))),
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                     
                  });
                  NavigatorService.pushNamed(AppRoutes.homeScreenNews);
                },
              ),
              GButton(
                icon: LineIcons.table,
                text: 'Demande',
                margin: EdgeInsets.symmetric(horizontal: 7),
                textStyle: (theme.textTheme.titleMedium?.copyWith(
                    fontSize: textSize,
                    color: const Color.fromARGB(255, 103, 102, 102))),
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                  NavigatorService.pushNamed(
                    role == "manager"
                        ? AppRoutes.homeADDAdmin
                        : AppRoutes.homeADD,
                  );
                },
              ),
              GButton(
                icon: LineIcons.bell,
                text: 'Notifications',
                margin: EdgeInsets.symmetric(horizontal: 7),
                textStyle: (theme.textTheme.titleMedium?.copyWith(
                    fontSize: textSize,
                    color: const Color.fromARGB(255, 103, 102, 102))),
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                  NavigatorService.pushNamed(AppRoutes.notificationScreenPage);
                },
              ),
              GButton(
                icon: LineIcons.cog,
                text: 'Settings',
                margin: EdgeInsets.symmetric(horizontal: 7),
                textStyle: (theme.textTheme.titleMedium?.copyWith(
                    fontSize: textSize,
                    color: const Color.fromARGB(255, 103, 102, 102))),
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                  NavigatorService.pushNamed(AppRoutes.settingsPage);
                },
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
                margin: EdgeInsets.only(right: 70, left: 7),
                textStyle: (theme.textTheme.titleMedium?.copyWith(
                    fontSize: textSize,
                    color: const Color.fromARGB(255, 103, 102, 102))),
                onPressed: () {
                  setState(() {
                    currentIndex = 4;
                  });
                  NavigatorService.pushNamed(AppRoutes.profileScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
