import 'package:flutter/material.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/dates/dates_extension.dart';
import 'package:movies_app/core/extensions/ui/media_query_extesion.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/mixin/snack_bar_mixin.dart';
import 'package:movies_app/core/widgets/images/network_movie_image_widget.dart';
import 'package:movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:movies_app/core/widgets/texts/text_widget.dart';
import 'package:movies_app/data/models/favorite_movie_model.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/buttons/favorite_icon_button_widget.dart';
import '../../../core/widgets/others/star_rating/star_rating_widget.dart';
import '../controllers/movie_details_controller.dart';

class MovieDetailsScreenWidget extends StatefulWidget {
  const MovieDetailsScreenWidget({super.key});

  @override
  State<MovieDetailsScreenWidget> createState() =>
      _MovieDetailsScreenWidgetState();
}

class _MovieDetailsScreenWidgetState extends State<MovieDetailsScreenWidget>
    with SnackBarMixin {
  void toggleFavorite(
    bool isFavorite,
    MovieDetailsController movieDetailsCtrl,
    MovieModel movie,
  ) async {
    final (errorMessage, successMessage) =
        await movieDetailsCtrl.toggleFavoriteMoivie(context, isFavorite, movie);

    if (context.mounted) {
      showSnackBar(
        context,
        errorMessage ?? successMessage!,
        errorMessage != null ? MessageType.error : MessageType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as MovieModel;

    final movieDetailsCtrl = Provider.of<MovieDetailsController>(context);

    final favoriteMovies = context.watch<List<FavoriteMovieModel>>();

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Hero(
                  tag: 'movie-picture-${movie.id}',
                  child: NetworkMovieImageWidget(
                    movieImage: movie.imagePath,
                    height: context.getHeight,
                    boxFit: BoxFit.cover,
                  ),
                ),
                collapsedHeight: context.getHeight,
                stretch: true,
              ),
            ],
          ),
          Positioned(
            top: context.getWidth / 2.5,
            width: context.getWidth,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.95),
                    Colors.black,
                  ],
                ),
              ),
              height: context.getHeight / 1.5,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  SizesEnum.md.getSize,
                  SizesEnum.md.getSize * 2.5,
                  SizesEnum.md.getSize,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget.title(
                      movie.title,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBoxWidget.xs(),
                    TextWidget.small(
                      'Nos cinemas dia ${movie.releaseDate.convertToDDMMAAA()}',
                    ),
                    const SizedBoxWidget.md(),
                    StarRatingWidget(
                      rating: (movie.voteAverage / 2).round(),
                    ),
                    const SizedBoxWidget.lg(),
                    TextWidget.title('Sinopse'),
                    const SizedBoxWidget.md(),
                    TextWidget.normal(
                      movie.overview,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBoxWidget.lg(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: context.getTopPadding + 2,
            right: 16,
            child: FavoriteIconButtonWidget(
              isFavorite: favoriteMovies.indexWhere(
                    (favoriteMovie) => favoriteMovie.id == movie.id,
                  ) !=
                  -1,
              onPressed: (bool isFavorite) {
                toggleFavorite(isFavorite, movieDetailsCtrl, movie);
              },
            ),
          )
        ],
      ),
    );
  }
}
