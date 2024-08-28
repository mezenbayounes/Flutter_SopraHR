// ignore_for_file: must_be_immutable

part of 'add_conge_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///AddConge widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class AddCongeEvent extends Equatable {}

/// Event that is dispatched when the AddConge widget is first created.
class AddCongeInitialEvent extends AddCongeEvent {
  @override
  List<Object?> get props => [];
}

class AskEvent extends AddCongeEvent {
  final String id;
  final String type;
  final String cause;
  final String date_debut;
  final String date_fin;
  final String sc_debut;
  final String sc_fin;

  AskEvent({
    required this.id,

    required this.type,
    required this.cause,
    required this.date_debut,
    required this.date_fin,
    required this.sc_debut,
    required this.sc_fin,
  });

  @override
  List<Object?> get props =>
      [id, type, cause, date_debut, date_fin, sc_debut, sc_fin];
}

class AskSuccessEvent extends AddCongeEvent {
  @override
  List<Object?> get props => [];
}

class AskFailureEvent extends AddCongeEvent {
  final String error;

  AskFailureEvent(this.error);

  @override
  List<Object?> get props => [error];
}
