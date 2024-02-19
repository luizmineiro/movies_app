import 'package:flutter/material.dart';
import 'package:movies_app/presentation/login/screen/login_screen.dart';
import 'package:movies_app/presentation/movie_details/screen/movie_details.dart';
import 'package:movies_app/presentation/nav/screen/nav_screen.dart';
import 'package:movies_app/presentation/signup/screen/signup_screen.dart';
import 'package:movies_app/presentation/splash/screen/splash_screen.dart';

class FirebaseMoviesAppRoute {
  static final FirebaseMoviesAppRoute _singleton =
      FirebaseMoviesAppRoute._internal();

  factory FirebaseMoviesAppRoute() {
    return _singleton;
  }

  FirebaseMoviesAppRoute._internal();

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      SplashScreen.routeName: (_) {
        return const SplashScreen();
      },
      LoginScreen.routeName: (_) {
        return const LoginScreen();
      },
      SignupScreen.routeName: (_) {
        return const SignupScreen();
      },
      NavScreen.routeName: (_) {
        return const NavScreen();
      },
      MovieDetails.routeName: (_) {
        return const MovieDetails();
      }
    };
  }
}
