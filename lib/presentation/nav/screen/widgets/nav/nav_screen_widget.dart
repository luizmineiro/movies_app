import 'package:flutter/material.dart';
import 'package:movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/media_query_extesion.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/mixin/navigation_mixin.dart';
import 'package:movies_app/core/services/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:movies_app/core/services/video_player/i_video_player.dart';
import 'package:movies_app/core/widgets/texts/text_widget.dart';
import 'package:movies_app/presentation/login/screen/login_screen.dart';
import 'package:movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'nav_button_widget.dart';

class NavScreenWidget extends StatefulWidget {
  const NavScreenWidget({super.key});

  @override
  State<NavScreenWidget> createState() => _NavScreenWidgetState();
}

class _NavScreenWidgetState extends State<NavScreenWidget>
    with NavigationMixin {
  late NavController navCtrl;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navCtrl.addListener(navTabIndexChange);
    });
    super.initState();
  }

  @override
  void dispose() {
    navCtrl.removeListener(navTabIndexChange);
    super.dispose();
  }

  void navTabIndexChange() {
    final videoPlayer = Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );
    if (navCtrl.navIndex == 0) {
      videoPlayer
        ..getController.unMute()
        ..play();
    } else {
      videoPlayer
        ..mute()
        ..pause();
    }
  }

  void onLogout(BuildContext context) async {
    final String? error = await FirebaseAuthService.logout();

    if (error == null && context.mounted) {
      handleNavigation(context, LoginScreen.routeName, clear: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    navCtrl = context.watch<NavController>();
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.normal(navCtrl.getTitle),
        actions: [
          IconButton(
            onPressed: () => onLogout(context),
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: TextWidget.normal("Movies"),
                ),
                if (navCtrl.navIndex == 1)
                  Center(
                    child: TextWidget.normal("Favorite Movies"),
                  )
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: FirebaseMoviesAppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: FirebaseMoviesAppColors.primaryColor,
                  blurRadius: 4,
                  spreadRadius: 3,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizesEnum.xs.getSize,
                right: SizesEnum.xs.getSize,
                bottom: SizesEnum.xs.getSize + context.getBottomPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavButtonWidget(
                      icon: Icons.movie,
                      onTap: () => navCtrl.selectNavIndex(0),
                      isSelected: navCtrl.navIndex == 0),
                  NavButtonWidget(
                      icon: Icons.favorite,
                      onTap: () => navCtrl.selectNavIndex(1),
                      isSelected: navCtrl.navIndex == 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
