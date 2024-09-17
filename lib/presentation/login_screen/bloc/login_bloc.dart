import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/core/constants/socket_service.dart';
import 'package:sopraflutter/main.dart';
import '/core/app_export.dart';
import 'package:sopraflutter/presentation/login_screen/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SocketService _socketService = SocketService(
      flutterLocalNotificationsPlugin:
          flutterLocalNotificationsPlugin); // Initialize the socket service

  LoginBloc(LoginState initialState) : super(initialState) {
    on<LoginInitialEvent>(_onInitialize);
    on<LoginSubmitEvent>(_onLoginSubmit);
    on<LoginSuccessEvent>(_onLoginSuccess);
    on<LoginFailureEvent>(_onLoginFailure);
  }

  void _onInitialize(LoginInitialEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController()));
    _socketService.initSocket(); // Initialize the socket connection
    _socketService.dispose(); // Dispose of the socket connection
  }

  Future<void> _onLoginSubmit(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        body: {'email': event.email, 'password': event.password},
      );

      if (response.statusCode == 200) {
        // Emit LoginSuccessEvent if the login is successful
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        String token = jsonMap['token'];
        int userID = jsonMap['userID'];

        print('token : $token');
        print('user ID : $userID');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setInt('userID', userID);
        _socketService.sendUserID(userID);

        emit(state.copyWith(isLoading: false));
        NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.homeScreenNews,
        );
        add(LoginSuccessEvent());
      } else {
        // Emit LoginFailureEvent with the error message if login fails
        emit(state.copyWith(isLoading: false, errorMessage: response.body));
        add(LoginFailureEvent(
          response.body,
        ));
      }
    } catch (e) {
      // Emit LoginFailureEvent with the exception message if an error occurs
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      add(LoginFailureEvent(e.toString()));
    }
  }

  Future<void> _onLoginSuccess(
      LoginSuccessEvent event, Emitter<LoginState> emit) async {
    // Handle login success event
    print('Login successful');
    // Optionally, you can navigate to another screen or perform other UI-related actions here
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int userID = prefs.getInt('userID') ?? 0;

    // HTTP POST request
    final response = await http.post(
      Uri.parse('$baseUrl/user/GetUserByID'),
      body: {'id': userID.toString()},
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final user = responseData['user'];

      // Save user data to SharedPreferences
      await prefs.setString('username', user['username']);
      await prefs.setString('email', user['email']);
      await prefs.setString('image_url', user['image_url']);
      await prefs.setString('role', user['role']);
      await prefs.setBool('isLoggedIn', true);

      print('User data saved successfully from login');
      String? username = prefs.getString('username');
      String? email = prefs.getString('email');
      String? image_url = prefs.getString('image_url');
      String? role = prefs.getString('role');
      print('test de shared:');
      print(username);
      print(email);
      print(image_url);
      print(role);
    } else {
      print("Error: Can't get user data");
    }
  }

  void _onLoginFailure(LoginFailureEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoading: false, errorMessage: event.error));
    print('Login failed: ${event.error}');

    try {
      // Attempt to parse the JSON error message
      final errorJson = jsonDecode(event.error);

      // Extract the specific error message
      final errorMessage = errorJson['error'] ?? 'Unknown error';

      // Print the extracted error message
      print('Login failed: $errorMessage');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = NavigatorService.navigatorKey.currentContext;
        if (context != null) {
          showErrorDialog(context, errorMessage);
        }
      });
    } catch (e) {
      // Handle cases where JSON parsing fails
      print('Failed to parse error message: ${event.error}');
    }
    // Ensure you have context available to show the dialog
  }

  Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              color: const Color.fromARGB(255, 231, 229, 229),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromARGB(255, 145, 145, 145),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
