import 'package:flutter/services.dart';
import 'package:online_learning_app/export.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final dynamic args;
  const VideoPlayer({super.key, this.args});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  TextEditingController _idController = TextEditingController();
  TextEditingController _seekToController = TextEditingController();

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  final Widget _space = const SizedBox(height: 10);
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  final List<String> _ids = [
    'THjekE5p2aw',
  ];

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.args["url_video"]).toString(),
      // initialVideoId: 'THjekE5p2aw',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                        _idController.text,
                      ) ??
                      '';
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          onEnterFullScreen: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            bottomActions: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    "/detail-video",
                    arguments: {
                      "id_course": widget.args["id_course"],
                      "id_video": (int.parse(widget.args["id_video"] + 1).toString()),
                      "url_video": widget.args["url_video"],
                    },
                  );
                },
                child: const Text("Next"),
              )
            ],
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) {
              _controller.load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
            },
          ),
          builder: (context, player) => Scaffold(
            body: ListView(
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                        ),
                      ),
                      _space,
                      _space,
                      Text(
                        _videoMetaData.title,
                        style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                      ),
                      _space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _videoMetaData.author,
                            style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
                          ),
                          Text(
                            _videoMetaData.duration.toString(),
                            style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
                          ),
                        ],
                      ),
                      _space,
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            onPressed: () {},
                            backgroundColor: kRedColor,
                            borderRadius: 20,
                            width: 120,
                            title: "Sebelumnya",
                          ),
                          CustomButton(
                            onPressed: () {},
                            borderRadius: 20,
                            width: 120,
                            backgroundColor: kGreenColor,
                            title: "Selanjutnya",
                          ),
                        ],
                      ),
                      _space,
                      _space,
                      _space,
                      _space,
                      _space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.skip_previous),
                            onPressed: _isPlayerReady ? () => _controller.load(_ids[(_ids.indexOf(_controller.metadata.videoId) - 1) % _ids.length]) : null,
                          ),
                          IconButton(
                            icon: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            onPressed: _isPlayerReady
                                ? () {
                                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                                    setState(() {});
                                  }
                                : null,
                          ),
                          IconButton(
                            icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                            onPressed: _isPlayerReady
                                ? () {
                                    _muted ? _controller.unMute() : _controller.mute();
                                    setState(() {
                                      _muted = !_muted;
                                    });
                                  }
                                : null,
                          ),
                          FullScreenButton(
                            controller: _controller,
                            color: Colors.blueAccent,
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next),
                            onPressed: _isPlayerReady ? () => _controller.load(_ids[(_ids.indexOf(_controller.metadata.videoId) + 1) % _ids.length]) : null,
                          ),
                        ],
                      ),
                      _space,
                      _space,
                      _space,
                      _space,
                      Row(
                        children: <Widget>[
                          const Text(
                            "Volume",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Expanded(
                            child: Slider(
                              inactiveColor: Colors.transparent,
                              value: _volume,
                              min: 0.0,
                              max: 100.0,
                              divisions: 10,
                              label: '${(_volume).round()}',
                              onChanged: _isPlayerReady
                                  ? (value) {
                                      setState(() {
                                        _volume = value;
                                      });
                                      _controller.setVolume(_volume.round());
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      _space,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color _getStateColor(PlayerState state) {
  switch (state) {
    case PlayerState.unknown:
      return Colors.grey[700]!;
    case PlayerState.unStarted:
      return Colors.pink;
    case PlayerState.ended:
      return Colors.red;
    case PlayerState.playing:
      return Colors.blueAccent;
    case PlayerState.paused:
      return Colors.orange;
    case PlayerState.buffering:
      return Colors.yellow;
    case PlayerState.cued:
      return Colors.blue[900]!;
    default:
      return Colors.blue;
  }
}
