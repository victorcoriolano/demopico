import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/features/profile/presentation/pages/full_screen_video_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final FileModel videoFile;
  const MyVideoPlayer({super.key, required this.videoFile});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoFile.filePath!)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: _controller.value.isInitialized
              ? AspectRatio(

                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(children:[ 
                    VideoPlayer(_controller),
                    Positioned(
                    
                    child: IconButton(
                        icon: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.to(() => FullScreenVideoPage(localFile: widget.videoFile,));
                        },), 
                  ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                    ),])
                )
              : Container(),
    );
  }
}