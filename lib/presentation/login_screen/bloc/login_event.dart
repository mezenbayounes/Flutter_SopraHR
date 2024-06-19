// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Login widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class LoginEvent extends Equatable {}

/// Event that is dispatched when the Login widget is first created.
class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}



class LoginSuccessEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}



class LoginFailureEvent extends LoginEvent {
  final String error;

  LoginFailureEvent(this.error);

  @override
  List<Object?> get props => [error];
}