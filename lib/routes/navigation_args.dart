import 'package:flutter/material.dart';

class NavigationArgs {
  static String id = "id";

  static String token = "token";
   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState!;
}
