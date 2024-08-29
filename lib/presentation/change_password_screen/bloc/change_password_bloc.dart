import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sopraflutter/presentation/login_screen/login_screen.dart';
import '/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/presentation/change_password_screen/models/change_password_model.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ChangePasswordBloc(ChangePasswordState initialState) : super(initialState) {
    on<ChangePasswordInitialEvent>(_onInitialize);
    on<ChangePasswordSubmitEvent>(_onSubmit);
    on<ChangePasswordSuccessEvent>(_onSuccess);
    on<ChangePasswordFailureEvent>(_onFailure);
  }

  void _onInitialize(
    ChangePasswordInitialEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
      passwordController: TextEditingController(),
      newpasswordController: TextEditingController(),
      newpasswordController1: TextEditingController(),
    ));
  }

  Future<void> _onSubmit(
    ChangePasswordSubmitEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/auth/ChangeForgotPassword'),
        body: {
          'email': event.email,
          'inputOtp': event.otp,
          'newPassword': event.NewPassword,
        },
      );

      if (response.statusCode == 200) {
        // Emit LoginSuccessEvent if the login is successful
        add(ChangePasswordSuccessEvent());
        NavigatorService.pushNamed(
          AppRoutes.loginScreen,
        );
      } else {
        // Emit LoginFailureEvent with the error message if login fails
        add(ChangePasswordFailureEvent(response.body));
      }
    } catch (e) {
      // Emit LoginFailureEvent with the exception message if an error occurs
      add(ChangePasswordFailureEvent(e.toString()));
    }
  }

  void _onSuccess(
    ChangePasswordSuccessEvent event,
    Emitter<ChangePasswordState> emit,
  ) {
    // Emit the current state if needed
    print('updated successfully');
  }

  void _onFailure(
    ChangePasswordFailureEvent event,
    Emitter<ChangePasswordState> emit,
  ) {
    // Handle login failure event
    print('update failed: ${event.error}');
    // Optionally, you can show an error message or perform other UI-related actions here
  }
}
