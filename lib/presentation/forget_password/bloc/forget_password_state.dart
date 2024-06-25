// ignore_for_file: must_be_immutable

part of 'forget_password_bloc.dart';

/// Represents the state of Login in the application.
class ForgetPasswordState extends Equatable {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
    final ForgetPasswordModel? forgetPasswordModel;

  final bool isLoading;
  final String? errorMessage;

  ForgetPasswordState({
    this.emailController,
    this.passwordController,
    this.forgetPasswordModel,
    this.isLoading = false,
    this.errorMessage,
  
  });

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        forgetPasswordModel,
        isLoading,
        errorMessage,
      ];

  ForgetPasswordState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    ForgetPasswordModel? forgetPasswordModel,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ForgetPasswordState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      forgetPasswordModel: forgetPasswordModel ?? this.forgetPasswordModel,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
