import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sopraflutter/presentation/change_password_screen/bloc/change_password_bloc.dart';
import 'core/app_export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sopraflutter/core/constants/socket_service.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final SocketService socketService = SocketService(
    flutterLocalNotificationsPlugin:
        flutterLocalNotificationsPlugin); // Initialize SocketService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the socket
  
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init()
    
  ]);

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_notification');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
  socketService.initSocket();
  socketService.dispose(); // Dispose of the socket connection
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(
        ChangePasswordState(
          passwordController: TextEditingController(),
          newpasswordController: TextEditingController(),
          newpasswordController1: TextEditingController(),
        ),
      ),
      child: BlocProvider(
        create: (context) => ThemeBloc(
          ThemeState(
            themeType: PrefUtils().getThemeData(),
          ),
        ),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: theme,
              title: 'sopraflutter',
              navigatorKey: NavigatorService.navigatorKey,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                AppLocalizationDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en', ''),
              ],
              initialRoute: AppRoutes.initialRoute,
              routes: AppRoutes.routes,
            );
          },
        ),
      ),
    );
  }
}
