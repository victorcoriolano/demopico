import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFromNetwork extends StatefulWidget {
  final String url;
  const VideoPlayerFromNetwork({super.key, required this.url});

  @override
  State<VideoPlayerFromNetwork> createState() => _VideoPlayerFromNetworkState();
}

class _VideoPlayerFromNetworkState extends State<VideoPlayerFromNetwork> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
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
    return Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children:[ 
                  VideoPlayer(_controller),
                  Positioned(
                    bottom: 10,
                    left: 10,
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