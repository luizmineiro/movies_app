import 'package:flutter/material.dart';
import 'package:movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/media_query_extesion.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/widgets/texts/text_widget.dart';
import 'package:movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:provider/provider.dart';

import 'nav_button_widget.dart';

class NavScreenWidget extends StatefulWidget {
  const NavScreenWidget({super.key});

  @override
  State<NavScreenWidget> createState() => _NavScreenWidgetState();
}

class _NavScreenWidgetState extends State<NavScreenWidget> {
  late NavController navCtrl;

  @override
  Widget build(BuildContext context) {
    navCtrl = context.watch<NavController>();
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.normal("Titulo"),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
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
                    isSelected: navCtrl.navIndex == 0
                  ),
                  NavButtonWidget(
                    icon: Icons.favorite,
                    onTap: () => navCtrl.selectNavIndex(1),
                    isSelected: navCtrl.navIndex == 1
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
