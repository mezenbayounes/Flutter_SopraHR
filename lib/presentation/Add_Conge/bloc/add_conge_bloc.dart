import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/app_export.dart';
import 'package:sopraflutter/presentation/Add_Conge/models/add_conge_model.dart';
part 'add_conge_event.dart';
part 'add_conge_state.dart';

/// A bloc that manages the state of a AddConge according to the event that is dispatched to it.
class AddCongeBloc extends Bloc<AddCongeEvent, AddCongeState> {
  AddCongeBloc(AddCongeState initialState) : super(initialState) {
    on<AddCongeInitialEvent>(_onInitialize);
    on<AskEvent>(_onAskSubmit);
    on<AskSuccessEvent>(_onAskSuccess);
    on<AskFailureEvent>(_onAskFailure);
  }

  _onInitialize(
    AddCongeInitialEvent event,
    Emitter<AddCongeState> emit,
  ) async {}

  Future<FutureOr<void>> _onAskSubmit(
      AskEvent event, Emitter<AddCongeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String? role = prefs.getString('role') ?? ""; // Update role state
    ;

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

  Future<FutureOr<void>> _onAskSuccess(
      AskSuccessEvent event, Emitter<AddCongeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? role = prefs.getString('role') ?? ""; // Update role state
    ;

    if (role == "manager") {
      NavigatorService.pushNamed(AppRoutes.homeADDAdmin);
    } else {
      NavigatorService.pushNamed(AppRoutes.homeADD);
    }
  }

  FutureOr<void> _onAskFailure(
      AskFailureEvent event, Emitter<AddCongeState> emit) {
    print('Ask failed: ${event.error}');
  }
}
