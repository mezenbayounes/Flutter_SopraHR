// ignore_for_file: must_be_immutable

part of 'add_tt_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///AddTT widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class AddTTEvent extends Equatable {}

/// Event that is dispatched when the AddTT widget is first created.
class AddTTInitialEvent extends AddTTEvent {
  @override
  List<Object?> get props => [];
}

class AskEvent extends AddTTEvent {
  final String id;
  final String date_debut;

  AskEvent({
    required this.id,
    required this.date_debut,
  });

  @override
  List<Object?> get props => [id, date_debut];
}

class AskSuccessEvent extends AddTTEvent {
  @override
  List<Object?> get props => [];
}

class AskFailureEvent extends AddTTEvent {
  final String error;

  AskFailureEvent(this.error);

  @override
  List<Object?> get props => [error];
}
