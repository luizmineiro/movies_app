import 'package:flutter/material.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/services/video_player/i_video_player.dart';
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
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: isPortrait ? 0 : 50,
                  bottom: isPortrait ? SizesEnum.md.getSize : 50,
                ),
                child: InkWell(
                  onTap: () {
                    Provider.of<IVideoPlayer<YoutubePlayerController>>(context,
                        listen: false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Scaffold(),
                          settings: RouteSettings(arguments: selectedMovie)),
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
            );
          },
        )
      ],
    );
  }
}
