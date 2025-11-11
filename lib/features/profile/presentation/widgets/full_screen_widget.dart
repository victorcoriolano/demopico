import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class FullScreenWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const FullScreenWidget({super.key, required this.controller});

  @override
  State<FullScreenWidget> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlack,
           appBar: AppBar(title: const Text(''), backgroundColor: Colors.transparent,),
           body: Stack(
             children: [
               VideoPlayer(widget.controller),
               Positioned(
                 bottom: 0,
                 left: 0,
                 right: 0,child: Row(
                   children: [
 IconButton(
                        icon: Icon(
                          widget.controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.controller.value.isPlaying
                                ? widget.controller.pause()
                                : widget.controller.play();
                          });
                        },
                      ),
                      
                     Expanded(child: VideoProgressIndicator(widget.controller, allowScrubbing: true, padding: EdgeInsets.all(8.0),)),
                   ],
                 )),
                
             ],
           ),
       );
  }
}