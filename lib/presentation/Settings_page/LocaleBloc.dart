import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  final Locale? locale;

  LocaleState({this.locale});

  @override
  List<Object?> get props => [locale];
}

class LocaleEvent {}

class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;

  ChangeLocaleEvent(this.locale);
}

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(locale: Locale('en', '')));

  @override
  Stream<LocaleState> mapEventToState(LocaleEvent event) async* {
    if (event is ChangeLocaleEvent) {
      yield LocaleState(locale: event.locale);
    }
  }
}
