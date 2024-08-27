import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/presentation/forget_password/models/forget_password_model.dart';
import '/core/app_export.dart';
import 'package:sopraflutter/presentation/login_screen/models/login_model.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<forgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc(ForgetPasswordState initialState) : super(initialState) {
    on<ForgetPasswordInitialEvent>(_onInitialize);
    on<ForgetPasswordSubmitEvent>(_onLoginSubmit);
    on<ForgetPasswordSuccessEvent>(_onLoginSuccess);
    on<ForgetPasswordFailureEvent>(_onLoginFailure);
  }

  void _onInitialize(ForgetPasswordInitialEvent event,
      Emitter<ForgetPasswordState> emit) async {
    emit(state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController()));
  }

  Future<void> _onLoginSubmit(ForgetPasswordSubmitEvent event,
      Emitter<ForgetPasswordState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/SendOTP'),
        body: {'email': event.email},
      );

      if (response.statusCode == 200) {
        // Emit LoginSuccessEvent if the login is successful
        emit(state.copyWith(isLoading: false));
        NavigatorService.pushNamed(
          AppRoutes.changePasswordScreen,
        );
        add(ForgetPasswordSuccessEvent());
      } else {
        // Emit LoginFailureEvent with the error message if login fails
        emit(state.copyWith(isLoading: false, errorMessage: response.body));
        add(ForgetPasswordFailureEvent(response.body));
      }
    } catch (e) {
      // Emit LoginFailureEvent with the exception message if an error occurs
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      add(ForgetPasswordFailureEvent(e.toString()));
    }
  }

  void _onLoginSuccess(
      ForgetPasswordSuccessEvent event, Emitter<ForgetPasswordState> emit) {
    // Handle login success event
    print('Login successful');

    // Optionally, you can navigate to another screen or perform other UI-related actions here
  }

  void _onLoginFailure(
      ForgetPasswordFailureEvent event, Emitter<ForgetPasswordState> emit) {
    // Handle login failure event
    print('Login failed: ${event.error}');
    // Optionally, you can show an error message or perform other UI-related actions here
  }
}
