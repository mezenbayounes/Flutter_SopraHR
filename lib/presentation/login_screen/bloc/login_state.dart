// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Represents the state of Login in the application.
class LoginState extends Equatable {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final LoginModel? loginModelObj;
  final bool isLoading;
  final String? errorMessage;

  LoginState({
    this.emailController,
    this.passwordController,
    this.loginModelObj,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        loginModelObj,
        isLoading,
        errorMessage,
      ];

  LoginState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    LoginModel? loginModelObj,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      loginModelObj: loginModelObj ?? this.loginModelObj,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
