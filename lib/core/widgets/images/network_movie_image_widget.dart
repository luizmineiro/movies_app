import 'package:flutter/material.dart';
import 'package:movies_app/core/services/dot_env_service.dart';

class NetworkMovieImageWidget extends StatelessWidget {
  final String movieImage;
  final double? height;
  final BoxFit? boxFit;

  const NetworkMovieImageWidget({
    super.key,
    required this.movieImage,
    this.height,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "${DotEnvService.getApiImageBaseUrl}$movieImage",
      height: height,
      fit: boxFit,
    );
  }
}
