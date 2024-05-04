import 'package:flutter/material.dart';
import 'package:movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';

class NavButtonWidget extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final bool isSelected;

  const NavButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? FirebaseMoviesAppColors.secondaryColor
        : FirebaseMoviesAppColors.whiteColor;
    return InkWell(
      onTap: onTap,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: color,
          size: SizesEnum.xl.getSize,
        ),
      ),
    );
  }
}
