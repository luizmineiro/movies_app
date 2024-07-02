import 'package:flutter/material.dart';
import 'package:movies_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:movies_app/data/models/favorite_movie_model.dart';
import 'package:provider/provider.dart';

import '../factories/movies_details_controller_factory.dart';
import '../widgets/movie_details_screen_widget.dart';

class MovieDetails extends StatelessWidget {
  static const String routeName = '/movie-details';

  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        makeMovieDetailsController(context),
        StreamProvider.value(
          value: FirebaseStoreService().getFavoriteMovies,
          initialData: const <FavoriteMovieModel>[],
        )
      ],
      child: MovieDetailsScreenWidget(),
    );
  }
}
