// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class defines the variables used in the [profile_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ProfileModel extends Equatable {
  ProfileModel() {}

  ProfileModel copyWith() {
    return ProfileModel();
  }
static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<Map<String, String?>> getDataFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String? email = prefs.getString('email');
  String? username = prefs.getString('username');
  String? imageUrl = prefs.getString('image_url');
  String? role = prefs.getString('role');
  
  return {
    'email': email,
    'username': username,
    'image_url': imageUrl,
    'role': role,
  };
}
  @override
  List<Object?> get props => [];
}
