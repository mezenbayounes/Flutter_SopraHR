// ignore_for_file: must_be_immutable

part of 'change_password_bloc.dart';

/// Represents the state of ChangePassword in the application.
class ChangePasswordState extends Equatable {
  ChangePasswordState({
    this.passwordController,
    this.newpasswordController,
    this.newpasswordController1,
    this.changePasswordModelObj,
  });

  TextEditingController? passwordController;

  TextEditingController? newpasswordController;

  TextEditingController? newpasswordController1;

  ChangePasswordModel? changePasswordModelObj;

  @override
  List<Object?> get props => [
        passwordController,
        newpasswordController,
        newpasswordController1,
        changePasswordModelObj,
      ];
  ChangePasswordState copyWith({
    TextEditingController? passwordController,
    TextEditingController? newpasswordController,
    TextEditingController? newpasswordController1,
    ChangePasswordModel? changePasswordModelObj,
  }) {
    return ChangePasswordState(
      passwordController: passwordController ?? this.passwordController,
      newpasswordController:
          newpasswordController ?? this.newpasswordController,
      newpasswordController1:
          newpasswordController1 ?? this.newpasswordController1,
      changePasswordModelObj:
          changePasswordModelObj ?? this.changePasswordModelObj,
    );
  }
  
}
class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  ChangePasswordSuccess(this.message);
}

class ChangePasswordError extends ChangePasswordState {
  final String errorMessage;

  ChangePasswordError(this.errorMessage);
}
