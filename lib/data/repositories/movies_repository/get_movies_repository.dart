import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/data/repositories/movies_repository/get_movie_video_repository.dart';

import '../../models/api_response_model.dart';
import '../../models/video_model.dart';
import '../api_repository/i_api_repository.dart';

class GetMoviesRepository {
  final IApiRepository _api;
  final GetMovieVideoRepository _getMovieVideoRepository;

  GetMoviesRepository(this._api, this._getMovieVideoRepository);

  Future<(String? error, List<MovieModel> movies)> getMovies() async {
    final (
      String? getMoviesError,
      ApiResponseModel<Map>? moviesResponse
    ) = await _api.get(
        '/3/discover/movie?include_adult=false&language=pt-BR&page=1&sort_by=popularity.desc');
    final moviesToReturn = <MovieModel>[];

    if (moviesResponse != null) {
      final moviesResults = moviesResponse.data["results"] as List;

      final List<Future<(String?, VideoModel?)>> moviesFuturesList =
          moviesResults
              .map<Future<(String?, VideoModel?)>>((movie) =>
                  _getMovieVideoRepository.getMovieVideo(movie["id"] as int))
              .toList();

      final videosResponse = await Future.wait(moviesFuturesList);

      for (var movie in moviesResults) {
        final int videoIndex = videosResponse
            .indexWhere((video) => video.$2?.movieId == movie['id']);

        if (videoIndex != -1) {
          movie['videoKey'] = videosResponse[videoIndex].$2?.videoKey;
        }
      }
      final movies = moviesResults
          .map<MovieModel>((movie) => MovieModel.fromMap(movie))
          .toList();
      moviesToReturn.addAll(movies);
    }
    return (getMoviesError, moviesToReturn);
  }
}
