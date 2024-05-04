import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/api_repository/i_api_repository.dart';
import '../../../data/repositories/movies_repository/get_movie_video_repository.dart';
import '../../../data/repositories/movies_repository/get_movies_repository.dart';
import '../controllers/nav_controller.dart';

ChangeNotifierProvider<NavController> makeNavController(BuildContext context) =>
    ChangeNotifierProvider<NavController>(
      create: (_) => NavController(
        GetMoviesRepository(
          Provider.of<IApiRepository>(context),
          GetMovieVideoRepository(Provider.of<IApiRepository>(context)),
        ),
      ),
    );
