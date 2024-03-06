import 'package:flutter/material.dart';

mixin LoginTextEdittingControllerMixin {
  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();

  void disposeLoginTECs() {
    emailTEC.dispose();
    passwordTEC.dispose();
  }
}
