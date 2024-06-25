import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:sopraflutter/presentation/profile_screen/models/profile_model.dart';
part 'profile_event.dart';
part 'profile_state.dart';

/// A bloc that manages the state of a Profile according to the event that is dispatched to it.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<ProfileInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ProfileInitialEvent event,
    Emitter<ProfileState> emit,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int userID = prefs.getInt('userID') ?? 0;
/////////////////////////////////////////////////////

    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/user/GetUserByID'),
      body: {'id': userID.toString()},
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("error can't get user data ");
    }
  }
///////////////////////////////////////////////////////
}
