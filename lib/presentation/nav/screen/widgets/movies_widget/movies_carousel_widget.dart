import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/const/assets_path_const.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/media_query_extesion.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/services/video_player/i_video_player.dart';
import 'package:movies_app/presentation/movie_details/screen/movie_details.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../../core/widgets/images/network_movie_image_widget.dart';
import '../../../controllers/nav_controller.dart';

class MoviesCarouselWidget extends StatelessWidget {
  final bool isPortrait;
  final double currentPage;
  final PageController moviesCarouselCtrl;

  const MoviesCarouselWidget({
    super.key,
    required this.isPortrait,
    required this.currentPage,
    required this.moviesCarouselCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Provider.of<NavController>(context);
    return Stack(
      children: [
        PageView.builder(
          itemCount: navCtrl.movieList.length,
          controller: moviesCarouselCtrl,
          itemBuilder: (_, index) {
            final selectedMovie = navCtrl.movieList[index];
            final scale = 1 / ((index - currentPage).abs() + 1);
            return Align(
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                alignment: Alignment.center,
                scale: scale,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: isPortrait ? 0 : 50,
                    bottom: isPortrait ? SizesEnum.md.getSize : 50,
                  ),
                  child: InkWell(
                    onTap: () {
                      Provider.of<IVideoPlayer<YoutubePlayerController>>(
                          context,
                          listen: false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MovieDetails(),
                          settings: RouteSettings(arguments: selectedMovie),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(SizesEnum.md.getSize),
                      child: Hero(
                        tag: "movies-picture-${selectedMovie.id}",
                        child: NetworkMovieImageWidget(
                          movieImage: selectedMovie.imagePath,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (moviesCarouselCtrl.hasClients &&
            currentPage.round() != moviesCarouselCtrl.page)
          Positioned(
            left: context.getWidth / 2 - 125,
            bottom: context.getHeight / 2 - 50,
            child: Lottie.asset(
              AssetsPathConst.animationPopcorn,
              width: 250,
            ),
          ),
      ],
    );
  }
}
