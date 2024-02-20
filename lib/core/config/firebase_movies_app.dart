import 'package:flutter/material.dart';
import 'package:movies_app/core/config/firebase_movies_app_initial_bindings.dart';
import 'package:movies_app/core/config/firebase_movies_app_material.dart';
import 'package:movies_app/core/config/firebase_movies_app_route.dart';
import 'package:movies_app/presentation/splash/screen/splash_screen.dart';
import 'package:provider/provider.dart';

class FirebaseMoviesApp extends StatelessWidget {
  const FirebaseMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: FirebaseMoviesAppInitialBindings.dependencies(),
      child: MaterialApp(
        title: FirebaseMoviesAppMaterial.title,
        theme: FirebaseMoviesAppMaterial.getTheme,
        initialRoute: SplashScreen.routeName,
        routes: FirebaseMoviesAppRoute.getRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
