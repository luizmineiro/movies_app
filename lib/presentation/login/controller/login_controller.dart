import 'package:flutter/material.dart';
import 'package:movies_app/core/services/firebase/firebase_auth/firebase_auth_service.dart';

class LoginController {
  final loginFormKey = GlobalKey<FormState>();
  Future<String?> onLogin(String email, String password) async {
    if (loginFormKey.currentState!.validate()) {
      final String? error = await FirebaseAuthService.login(email, password);

      if (error != null) {
        return "Email ou senha invalidos!";
      }

      return null;
    }
    return "Formulario invalido";
  }
}
