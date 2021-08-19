import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerState();
  }
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _youtubePlayerController;
  late PlayerState _playerState;

  late YoutubeMetaData _videoMetaData;

  bool _isPlayerReady = false;
  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: "W1vKz21UvX4",
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          enableCaption: true,
          controlsVisibleAtStart: true),
    )..addListener(_videoPlayerListner);
    _playerState = PlayerState.unknown;
  }

  void _videoPlayerListner() {
    print(_youtubePlayerController.value.playerState.toString());
    if (_isPlayerReady &&
        mounted &&
        !_youtubePlayerController.value.isFullScreen) {
      setState(() {
        _playerState = _youtubePlayerController.value.playerState;
        _videoMetaData = _youtubePlayerController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _youtubePlayerController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      topActions: <Widget>[
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            _youtubePlayerController.metadata.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () {
            print('Settings Tapped!');
          },
        ),
      ],
      onReady: () {
        _isPlayerReady = true;
      },
    );
  }
}
