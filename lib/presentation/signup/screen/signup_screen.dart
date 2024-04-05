import 'package:flutter/material.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/inputs/text_form_field_widget.dart';
import 'package:movies_app/core/mixin/loading_error_mixin.dart';
import 'package:movies_app/core/mixin/navigation_mixin.dart';
import 'package:movies_app/core/mixin/snack_bar_mixin.dart';
import 'package:movies_app/core/validators/email_validator.dart';
import 'package:movies_app/core/validators/password_validator.dart';
import 'package:movies_app/core/widgets/buttons/button_widget.dart';
import 'package:movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:movies_app/core/widgets/texts/text_widget.dart';
import 'package:movies_app/presentation/nav/screen/nav_screen.dart';
import 'package:movies_app/presentation/signup/mixins/signup_text_editing_controller_mixin.dart';

import '../controller/signup_controller.dart';
import '../mixins/signup_focus_nodes_mixin.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with
        NavigationMixin,
        LoadingErrorMixin,
        SnackBarMixin,
        SignupFocusNodesMixin,
        SignupTextEditingControllerMixin {
  late SignupController signupCtrl;
  
  @override
  void initState() {
    signupCtrl = SignupController();
    setIsLoading(false);
    super.initState();
  }

  @override
  void dispose() {
    disposeFN();
    disposeTECs();
    super.dispose();
  }

  void onSignup(BuildContext context) async {
    setIsLoading(true);
    setError(null);
    final (errorMessage, success) =
        await signupCtrl.onSignup(emailTEC.text, passwordTEC.text);
    if (success && context.mounted) {
      handleNavigation(context, NavScreen.routeName);
    } else {
      setIsLoading(false);
      if (errorMessage != null) {
        showSnackBar(context, errorMessage, MessageType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: signupCtrl.signupFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizesEnum.lg.getSize,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBoxWidget.lg(),
                TextWidget.title("Registro"),
                const SizedBoxWidget.md(),
                TextFormFieldWidget(
                  inputLabel: "Email",
                  controller: emailTEC,
                  focusNode: emailFN,
                  validator: EmailValidator.validate,
                  textInputType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) => passwordFN.requestFocus(),
                ),
                const SizedBoxWidget.md(),
                TextFormFieldWidget(
                  inputLabel: "Senha",
                  controller: passwordTEC,
                  focusNode: passwordFN,
                  validator: PasswordValidator.validate,
                  isPassword: true,
                  onFieldSubmitted: (_) => onSignup(context),
                  textInputAction: TextInputAction.send,
                ),
                const SizedBoxWidget.xxl(),
                ButtonWidget(
                  label: "Registrar",
                  onPressed: () => onSignup(context),
                  isBlock: true,
                  isLoading: isLoading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
