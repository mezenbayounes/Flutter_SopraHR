import 'dart:convert';

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
        Uri.parse('http://10.0.2.2:3000/auth/login'),
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
          AppRoutes.profileScreen,
        );
        add(LoginSuccessEvent());
      } else {
        // Emit LoginFailureEvent with the error message if login fails
        emit(state.copyWith(isLoading: false, errorMessage: response.body));
        add(LoginFailureEvent(response.body));
      }
    } catch (e) {
      // Emit LoginFailureEvent with the exception message if an error occurs
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      add(LoginFailureEvent(e.toString()));
    }
  }

  void _onLoginSuccess(LoginSuccessEvent event, Emitter<LoginState> emit) {
    // Handle login success event
    print('Login successful');
    // Optionally, you can navigate to another screen or perform other UI-related actions here
  }

  void _onLoginFailure(LoginFailureEvent event, Emitter<LoginState> emit) {
    // Handle login failure event
    print('Login failed: ${event.error}');
    // Optionally, you can show an error message or perform other UI-related actions here
  }
}
