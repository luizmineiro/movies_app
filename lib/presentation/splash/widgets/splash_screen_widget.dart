import 'package:flutter/material.dart';
import 'package:movies_app/core/const/assets_path_const.dart';
import 'package:movies_app/core/mixin/navigation_mixin.dart';
import 'package:movies_app/core/services/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:movies_app/core/widgets/texts/text_widget.dart';
import 'package:movies_app/presentation/login/screen/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/presentation/nav/screen/nav_screen.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with NavigationMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 4));
      final user = FirebaseAuthService.getUser;
      if (context.mounted) {
        if (user == null) {
          handleNavigation(context, LoginScreen.routeName, clear: true);
        } else {
          handleNavigation(context, NavScreen.routeName, clear: true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Lottie.asset(AssetsPathConst.animationSplash),
          ),
          const SizedBoxWidget.md(),
          TextWidget.title('Loading ...')
        ],
      ),
    );
  }
}
