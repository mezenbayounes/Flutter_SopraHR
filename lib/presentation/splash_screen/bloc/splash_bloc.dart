import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/app_export.dart';
import 'package:sopraflutter/presentation/splash_screen/models/splash_model.dart';
part 'splash_event.dart';
part 'splash_state.dart';

/// A bloc that manages the state of a Splash according to the event that is dispatched to it.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(SplashState initialState) : super(initialState) {
    on<SplashInitialEvent>(_onInitialize);
  }

  _onInitialize(
    SplashInitialEvent event,
    Emitter<SplashState> emit,
  ) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Navigate to home
    Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.homeScreenNews,
      );
    });
    } else {
     Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.loginScreen,
      );
    });
    }
  }
  }
 
  