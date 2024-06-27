import 'package:flutter/material.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/media_query_extesion.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/widgets/images/network_movie_image_widget.dart';
import 'package:movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:movies_app/core/widgets/texts/text_widget.dart';
import 'package:movies_app/data/models/favorite_movie_model.dart';
import 'package:movies_app/presentation/movie_details/screen/movie_details.dart';
import 'package:movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:provider/provider.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = context.watch<NavController>();
    final favoriteMovies = Provider.of<List<FavoriteMovieModel>>(context);

    return ColoredBox(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                SizesEnum.md.getSize,
                SizesEnum.md.getSize,
                SizesEnum.md.getSize,
                0,
              ),
              child: favoriteMovies.isEmpty
                  ? Center(
                      child: TextWidget.normal(
                        "Você ainda não possui nenhum filme favorito!",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoriteMovies.length,
                      itemBuilder: (_, int index) {
                        final favoriteMovie = favoriteMovies[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                            NavController>.value(
                                          value: navCtrl,
                                          child: const MovieDetails(),
                                        ),
                                    settings: RouteSettings(
                                        arguments: favoriteMovie)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: context.getWidth * 0.35,
                                    child: NetworkMovieImageWidget(
                                      movieImage: favoriteMovie.imagePath,
                                    ),
                                  ),
                                  const SizedBoxWidget.md(),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextWidget.normal(
                                          favoriteMovie.title,
                                        ),
                                        const SizedBoxWidget.sm(),
                                        TextWidget.small(
                                          favoriteMovie.overview,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBoxWidget.md(),
                          ],
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
