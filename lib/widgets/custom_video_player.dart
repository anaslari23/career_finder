import 'package:flutter/material.dart';

import 'package:login_page/constants/icons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late YoutubePlayerController _controller;
  Widget? controls;

  @override
  void initState() {
    super.initState();

    // Replace the YouTube video ID below
    _controller = YoutubePlayerController(
      initialVideoId: 'https://www.youtube.com/watch?v=-SKSihRjKQA',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          controls = GestureDetector(
            onTap: () {
              setState(() {
                _controller.pause();
              });
            },
            child: Image.asset(
              icPause,
              height: 50,
            ),
          );
        });
      } else {
        setState(() {
          controls = GestureDetector(
            onTap: () {
              setState(() {
                _controller.play();
              });
            },
            child: Image.asset(
              icLearning,
              height: 50,
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // Use the aspect ratio of a standard YouTube video
      child: Stack(
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return player;
            },
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [controls ?? Container()],
            ),
          ),
        ],
      ),
    );
  }
}
