import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_learning_app/bloc/auth/create_watch/create_watch_bloc.dart';
import 'package:online_learning_app/bloc/auth/is_watched/is_watched_bloc.dart';
import 'package:online_learning_app/bloc/course/video/get_video_by_course_id_and_author_id/get_video_by_course_id_and_author_id_bloc.dart';
import 'package:online_learning_app/bloc/course/video/get_video_by_id/get_video_by_id_bloc.dart';
import 'package:online_learning_app/screens/user/video/user_video_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../export.dart';

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
  bool _isPlaying = false;
  final Widget _space = const SizedBox(height: 10);
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  // final List<String> _ids = [
  //   'THjekE5p2aw',
  // ];

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
    context.read<GetVideoByCourseIdAndAuthorIdBloc>().add(VideoByCourseIdAndAuthorIdEvent(courseId: widget.args["id_course"].toString()));
    context.read<GetVideoByIdBloc>().add(VideoByIdEvent(id: widget.args["id_video"]));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetVideoByIdBloc, GetVideoByIdState>(
        builder: (context, state) {
          if (state is GetVideoByIdLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetVideoByIdError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GetVideoByIdSuccess) {
            _controller = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(state.video.data![0].video.toString()).toString(),
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
            return SafeArea(
              child: YoutubePlayerBuilder(
                onEnterFullScreen: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ]);
                },
                onExitFullScreen: () {
                  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                },
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  onReady: () {
                    _isPlayerReady = true;
                  },
                  onEnded: (data) {
                    _controller.load(widget.args["url_video"][(widget.args["url_video"].indexOf(data.videoId) + 1) % widget.args["url_video"].length]);
                  },
                ),
                builder: (context, player) => Scaffold(
                  body: ListView(
                    children: [
                      player,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _space,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Materi ke : ${widget.args["materi"]}",
                                  style: greyTextStyle.copyWith(fontWeight: regular),
                                ),
                                BlocListener<CreateWatchBloc, CreateWatchState>(
                                  listener: (context, state) {
                                    if (state is CreateWatchSuccess) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: const Duration(seconds: 5),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: kGreenColor,
                                          content: Row(
                                            children: [
                                              const Icon(Icons.beenhere_rounded, color: Colors.white),
                                              const SizedBox(width: 12),
                                              Text(
                                                'Mark to watched Videos',
                                                style: whiteTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      context.read<CreateWatchBloc>().add(CreateWatchedVideos(videoId: widget.args["id_video"]));
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.check,
                                      color: kUnavailableColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _space,
                            Text(
                              widget.args["title"],
                              style: blackTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: bold,
                              ),
                            ),
                            _space,
                            _space,
                            _space,
                            CustomButton(
                              backgroundColor: kRedColor,
                              height: 50,
                              borderRadius: 20,
                              width: 160,
                              title: 'Semua Video',
                              style: whiteTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            _space,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
