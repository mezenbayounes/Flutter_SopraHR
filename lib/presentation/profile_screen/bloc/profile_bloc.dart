import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/presentation/profile_screen/models/profile_model.dart';
import 'dart:convert'; // To use jsonDecode
part 'profile_event.dart';
part 'profile_state.dart';

/// A bloc that manages the state of a Profile according to the event that is dispatched to it.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<ProfileInitialEvent>(_onInitialize);
    on<ProfileForgetPasswordSubmitEvent>(_ProfileForgetPasswordSubmit);
  }

  void _onInitialize(
    ProfileInitialEvent event,
    Emitter<ProfileState> emit,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int userID = prefs.getInt('userID') ?? 0;

    // HTTP POST request
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/user/GetUserByID'),
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

      print('User data saved successfully');
      String? username = prefs.getString('username');
      String? email = prefs.getString('email');
      String? image_url = prefs.getString('image_url');
      String? role = prefs.getString('role');
      print('test de shered:');
      print(username);
      print(email);
      print(image_url);
      print(role);
    } else {
      print("Error: Can't get user data");
    }
  }

  FutureOr<void> _ProfileForgetPasswordSubmit(
      ProfileForgetPasswordSubmitEvent event,
      Emitter<ProfileState> emit) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/SendOTP'),
        body: {'email': event.email},
      );

      if (response.statusCode == 200) {
        // Emit LoginSuccessEvent if the login is successful

        NavigatorService.pushNamed(
          AppRoutes.changePasswordScreen,
        );
        print('otp sended');
      } else {
        // Emit LoginFailureEvent with the error message if login fails
        print('error send otp');
      }
    } catch (e) {
      print('error send otp : $e');
    }
  }
}
