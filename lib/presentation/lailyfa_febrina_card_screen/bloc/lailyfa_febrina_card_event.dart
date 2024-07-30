// ignore_for_file: must_be_immutable

part of 'lailyfa_febrina_card_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///LailyfaFebrinaCard widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class LailyfaFebrinaCardEvent extends Equatable {}

/// Event that is dispatched when the LailyfaFebrinaCard widget is first created.
class LailyfaFebrinaCardInitialEvent extends LailyfaFebrinaCardEvent {
  @override
  List<Object?> get props => [];
}

class AskEvent extends LailyfaFebrinaCardEvent {
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
  List<Object?> get props => [id, type, cause, date_debut, date_fin, sc_debut, sc_fin];
}

class AskSuccessEvent extends LailyfaFebrinaCardEvent {
  @override
  List<Object?> get props => [];
}

class AskFailureEvent extends LailyfaFebrinaCardEvent {
  final String error;

  AskFailureEvent(this.error);

  @override
  List<Object?> get props => [error];
}
