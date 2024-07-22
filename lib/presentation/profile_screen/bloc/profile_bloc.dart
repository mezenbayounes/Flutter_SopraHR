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
  ) {}

  FutureOr<void> _ProfileForgetPasswordSubmit(
      ProfileForgetPasswordSubmitEvent event,
      Emitter<ProfileState> emit) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/SendOTP'),
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
