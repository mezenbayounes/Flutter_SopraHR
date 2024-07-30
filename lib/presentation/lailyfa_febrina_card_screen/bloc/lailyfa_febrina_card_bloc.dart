import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/app_export.dart';
import 'package:sopraflutter/presentation/lailyfa_febrina_card_screen/models/lailyfa_febrina_card_model.dart';
part 'lailyfa_febrina_card_event.dart';
part 'lailyfa_febrina_card_state.dart';

/// A bloc that manages the state of a LailyfaFebrinaCard according to the event that is dispatched to it.
class LailyfaFebrinaCardBloc
    extends Bloc<LailyfaFebrinaCardEvent, LailyfaFebrinaCardState> {
  LailyfaFebrinaCardBloc(LailyfaFebrinaCardState initialState)
      : super(initialState) {
    on<LailyfaFebrinaCardInitialEvent>(_onInitialize);
    on<AskEvent>(_onAskSubmit);
    on<AskSuccessEvent>(_onAskSuccess);
    on<AskFailureEvent>(_onAskFailure);
  }

  _onInitialize(
    LailyfaFebrinaCardInitialEvent event,
    Emitter<LailyfaFebrinaCardState> emit,
  ) async {}

  Future<FutureOr<void>> _onAskSubmit(
      AskEvent event, Emitter<LailyfaFebrinaCardState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/conge/CreateConge'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type':
              'application/x-www-form-urlencoded', // Or 'application/json' if you are sending JSON
        },
        body: {
          'userId': event.id,
          'typeConge': event.type,
          'cause': event.cause,
          'dateDebut': event.date_debut,
          'scDebut': event.sc_debut,
          'dateFin': event.date_fin,
          'scFin': event.sc_fin
        },
      );

      if (response.statusCode == 200) {
        NavigatorService.pushNamed(
          AppRoutes.homeScreenNews,
        );
        add(AskSuccessEvent());
      } else {
        // Emit LoginFailureEvent with the error message if login fails

        add(AskFailureEvent(
          response.body,
        ));
      }
    } catch (e) {
      // Emit LoginFailureEvent with the exception message if an error occurs
      add(AskFailureEvent(e.toString()));
    }
  }

  FutureOr<void> _onAskSuccess(
      AskSuccessEvent event, Emitter<LailyfaFebrinaCardState> emit) {
    NavigatorService.pushNamed(
      AppRoutes.homeADDAdmin,
    );
    print('demande successful send');
  }

  FutureOr<void> _onAskFailure(
      AskFailureEvent event, Emitter<LailyfaFebrinaCardState> emit) {
    print('Ask failed: ${event.error}');
  }
}
