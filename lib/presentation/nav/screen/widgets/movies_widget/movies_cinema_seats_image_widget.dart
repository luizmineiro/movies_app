import 'package:flutter/material.dart';
import 'package:movies_app/core/const/assets_path_const.dart';
import 'package:movies_app/core/extensions/ui/media_query_extesion.dart';

class MoviesCinemaSeatsImageWidget extends StatelessWidget {
  const MoviesCinemaSeatsImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -50,
      left: 0,
      height: context.getWidth,
      width: context.getWidth,
      child: Image.asset(
        AssetsPathConst.cinemaImage,
        fit: BoxFit.contain,
      ),
    );
  }
}
