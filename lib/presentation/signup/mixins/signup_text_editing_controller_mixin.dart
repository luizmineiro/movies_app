
import 'package:flutter/material.dart';

mixin SignupTextEditingControllerMixin {
  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();

  void disposeTEC(){
    emailTEC.dispose();
    passwordTEC.dispose();
  }
}