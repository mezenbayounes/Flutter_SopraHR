// ignore_for_file: must_be_immutable

part of 'forget_password_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Login widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class forgetPasswordEvent extends Equatable {}

/// Event that is dispatched when the Login widget is first created.
class ForgetPasswordInitialEvent extends forgetPasswordEvent {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSubmitEvent extends forgetPasswordEvent {
  final String email;

  ForgetPasswordSubmitEvent({required this.email});

  @override
  List<Object?> get props => [email];
}



class ForgetPasswordSuccessEvent extends forgetPasswordEvent {
  @override
  List<Object?> get props => [];
}



class ForgetPasswordFailureEvent extends forgetPasswordEvent {
  final String error;

  ForgetPasswordFailureEvent(this.error);

  @override
  List<Object?> get props => [error];
}