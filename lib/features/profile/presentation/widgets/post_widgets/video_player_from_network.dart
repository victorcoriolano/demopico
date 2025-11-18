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
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url),)
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
    // Verificando carregamento.
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    // O Stack vai preencher o espaço dado pelo GridView.
    return Stack(
      fit: StackFit.expand, 
      children: [
        FittedBox(
          fit: BoxFit.cover,
          // Clip.hardEdge corta o que vaza para fora do container.
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),

        Align(
          child: IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
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
        ),
      ],
    );
  }
}