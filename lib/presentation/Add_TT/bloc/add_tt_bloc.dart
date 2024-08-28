import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sopraflutter/presentation/Add_TT/models/add_tt_model.dart';
import '/core/app_export.dart';
import 'package:sopraflutter/presentation/Add_Conge/models/add_conge_model.dart';
part 'add_tt_event.dart';
part 'add_tt_state.dart';

/// A bloc that manages the state of a AddTT according to the event that is dispatched to it.
class AddTTBloc extends Bloc<AddTTEvent, AddTTState> {
  AddTTBloc(AddTTState initialState) : super(initialState) {
    on<AddTTInitialEvent>(_onInitialize);
    on<AskEvent>(_onAskSubmit);
    on<AskSuccessEvent>(_onAskSuccess);
    on<AskFailureEvent>(_onAskFailure);
  }

  _onInitialize(
    AddTTInitialEvent event,
    Emitter<AddTTState> emit,
  ) async {}

  Future<FutureOr<void>> _onAskSubmit(
      AskEvent event, Emitter<AddTTState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    ;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/remote/CreateRemote'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type':
              'application/x-www-form-urlencoded', // Or 'application/json' if you are sending JSON
        },
        body: {
          'userId': event.id,
          'dateRemote': event.date_debut,
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
      AskSuccessEvent event, Emitter<AddTTState> emit) async {
    NavigatorService.pushNamed(AppRoutes.homeADD);
    print('demande successful send');
  }

  FutureOr<void> _onAskFailure(
      AskFailureEvent event, Emitter<AddTTState> emit) {
    print('Ask failed: ${event.error}');
    try {
      // Attempt to parse the JSON error message
      final errorJson = jsonDecode(event.error);

      // Extract the specific error message
      final errorMessage = errorJson['error'] ?? 'Unknown error';

      // Print the extracted error message
      print('Login failed: $errorMessage');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = NavigatorService.navigatorKey.currentContext;
        if (context != null) {
          showErrorDialog(context, errorMessage);
        }
      });
    } catch (e) {
      // Handle cases where JSON parsing fails
      print('Failed to parse error message: ${event.error}');
    }
  }

  Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              color: const Color.fromARGB(255, 231, 229, 229),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromARGB(255, 145, 145, 145),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
