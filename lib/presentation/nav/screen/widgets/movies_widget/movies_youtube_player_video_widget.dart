import 'package:flutter/material.dart';
import 'package:movies_app/core/enums/sized_enum.dart';
import 'package:movies_app/core/extensions/ui/media_query_extesion.dart';
import 'package:movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:movies_app/core/services/video_player/i_video_player.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MoviesYoutubePlayerVideoWidget extends StatelessWidget {
  final bool isPortrait;
  const MoviesYoutubePlayerVideoWidget({
    super.key,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    final videoPlayerCtrl =
        Provider.of<IVideoPlayer<YoutubePlayerController>>(context);
    return Positioned(
      width: context.getWidth,
      height: context.getHeight,
      top: -context.getHeight * 0.25,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isPortrait ? SizesEnum.sm.getSize : 0,
        ),
        child: YoutubePlayer(
          controller: videoPlayerCtrl.getController,
          aspectRatio: 1,
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
