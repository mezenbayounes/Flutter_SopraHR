import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '/core/app_export.dart';
import 'package:sopraflutter/presentation/login_screen/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
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

        emit(state.copyWith(isLoading: false));
        NavigatorService.pushNamed(
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
    // Handle login failure event
    print('Login failed: ${event.error}');
    // Optionally, you can show an error message or perform other UI-related actions here
  }
}
