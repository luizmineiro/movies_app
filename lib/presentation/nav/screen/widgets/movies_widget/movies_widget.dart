import 'package:flutter/material.dart';
import 'package:movies_app/core/mixin/loading_error_mixin.dart';
import 'package:movies_app/core/services/video_player/i_video_player.dart';
import 'package:movies_app/presentation/nav/controllers/movies_widget_controller.dart';
import 'package:movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../../core/widgets/others/error_with_button_widget/error_with_button_widget.dart';
import 'movies_carousel_widget.dart';
import 'movies_cinema_seats_image_widget.dart';
import 'movies_youtube_player_video_widget.dart';

class MoviesWidget extends StatefulWidget {
  const MoviesWidget({super.key});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> with LoadingErrorMixin {
  final _moviesCarouselCtrl = PageController(viewportFraction: 0.4);

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      _moviesCarouselCtrl.addListener(changeVideoPageListener);
    });
    getMoviesAndInitVideo();
    super.initState();
  }

  void changeVideoPageListener() {
    final navCtrl = Provider.of<NavController>(context, listen: false);
    final moviesWidgetCtrl =
        Provider.of<MoviesWidgetController>(context, listen: false);

    setState(() {
      moviesWidgetCtrl.currentPage = _moviesCarouselCtrl.page ?? 0;
    });

    if (moviesWidgetCtrl.currentPage.round() == moviesWidgetCtrl.currentPage) {
      initVideo(
        navCtrl.movieList[moviesWidgetCtrl.currentPage.round()].videoId,
      );
    }
  }

  void initVideo([String? videoId]) {
    final navCtrl = Provider.of<NavController>(context, listen: false);
    final videoPlayerCtrl = Provider.of<IVideoPlayer<YoutubePlayerController>>(
        context,
        listen: false);

    final firstVideoWithId =
        navCtrl.movieList.firstWhere((video) => video.videoId != null);

    videoPlayerCtrl.load(videoId ?? firstVideoWithId.videoId!);
  }

  Future<void> getMoviesAndInitVideo() async {
    final navCtrl = Provider.of<NavController>(context, listen: false);

    setError(null);
    setIsLoading(true);

    final error = await navCtrl.getMovies();

    setIsLoading(false);
    setError(error);

    if (error == null) {
      initVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navCtrl = Provider.of<NavController>(context);
    final moviesWidgetCtrl = Provider.of<MoviesWidgetController>(context);
    return OrientationBuilder(
      builder: (_, Orientation orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return errorMessage != null
            ? ErrorWithButtonWidget(
                errorMessage: errorMessage!,
                tryAgain: getMoviesAndInitVideo,
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (!isLoading)
                    MoviesYoutubePlayerVideoWidget(isPortrait: isPortrait),
                  if (isPortrait) const MoviesCinemaSeatsImageWidget(),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!isLoading && navCtrl.movieList.isNotEmpty)
                    MoviesCarouselWidget(
                      currentPage: moviesWidgetCtrl.currentPage,
                      isPortrait: isPortrait,
                      moviesCarouselCtrl: _moviesCarouselCtrl,
                    ),
                ],
              );
      },
    );
  }
}
