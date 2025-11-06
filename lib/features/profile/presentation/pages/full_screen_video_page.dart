import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/features/profile/presentation/widgets/full_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPage extends StatefulWidget {
  final FileModel? localFile;
  final String? urlVideo;
  const FullScreenVideoPage({ super.key, this.localFile , this.urlVideo});

  @override
  State<FullScreenVideoPage> createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.localFile != null ? VideoPlayerController.asset(widget.localFile!.filePath!) : VideoPlayerController.networkUrl(Uri.parse(widget.urlVideo!));
    _controller.initialize().then((_) {setState(() {
      _controller.play();
    });});
  }
   @override
   Widget build(BuildContext context) {
       return FullScreenWidget(controller: _controller);
  }
}