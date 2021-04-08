import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../constatns.dart';

class YouTubePlayer extends StatefulWidget {
  const YouTubePlayer({
    Key? key,
    required this.youtubeVideoId,
  }) : super(key: key);
  final String youtubeVideoId;

  @override
  _YouTubePlayerState createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.youtubeVideoId,
    params: const YoutubePlayerParams(
      autoPlay: false,
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: kShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: YoutubePlayerIFrame(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
