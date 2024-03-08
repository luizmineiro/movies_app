// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/const/assets_path_const.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/inputs/text_form_field_widget.dart';
import 'package:movies_app/core/mixin/loadin_error_mixin.dart';
import 'package:movies_app/core/mixin/navigation_mixin.dart';
import 'package:movies_app/core/mixin/snack_bar_mixin.dart';
import 'package:movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:movies_app/presentation/login/controller/login_controller.dart';
import 'package:movies_app/presentation/login/mixins/login_focus_nodes_mixin.dart';
import 'package:movies_app/presentation/login/mixins/login_text_editting_controller_mixin.dart';
import 'package:movies_app/presentation/nav/screen/nav_screen.dart';

import '../../../core/widgets/texts/text_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with
        LoginFocusNodesMixin,
        LoginTextEdittingControllerMixin,
        NavigationMixin,
        LoadinErrorMixin,
        SnackBarMixin {
  late LoginController loginController;
  @override
  void initState() {
    loginController = LoginController();
    setIsLoading(false);
    super.initState();
  }

  void onLogin() async {
    setIsLoading(true);
    final error =
        await loginController.onLogin(emailTEC.text, passwordTEC.text);

    if (error != null && context.mounted) {
      showSnackBar(context, error, MessageType.error);
    } else {
      handleNavigation(context, NavScreen.routeName, clear: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginController.loginFormKey,
        child: Padding(
          padding: EdgeInsets.all(SizesEnum.lg.getSize),
          child: SizedBox.expand(
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Lottie.asset(AssetsPathConst.animationLogin),
                ),
                const SizedBoxWidget.md(),
                TextWidget.title("Firebase Movies App"),
                const SizedBoxWidget.md(),
                TextFormFieldWidget(
                  inputLabel: 'Email',
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
