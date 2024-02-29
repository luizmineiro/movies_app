import 'package:flutter/material.dart';

import '../../../core/widgets/texts/text_widget.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextWidget.title('Login Screen'),
      ),
    );
  }
}
