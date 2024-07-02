import 'package:flutter/material.dart';
import 'package:movies_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:provider/provider.dart';

import '../controllers/movie_details_controller.dart';

Provider<MovieDetailsController> makeMovieDetailsController(
        BuildContext context) =>
    Provider<MovieDetailsController>(
      create: (_) => MovieDetailsController(
        FirebaseStoreService(),
      ),
    );
