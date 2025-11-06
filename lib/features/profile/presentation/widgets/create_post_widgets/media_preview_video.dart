import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaPreviewVideo extends StatefulWidget {
  final FileModel? videoFile; 
  final Function(FileModel) onRemoveMedia;
  const MediaPreviewVideo({super.key, required this.videoFile, required this.onRemoveMedia});

  @override
  State<MediaPreviewVideo> createState() => _MediaPreviewVideoState();
}

class _MediaPreviewVideoState extends State<MediaPreviewVideo> {
  @override
  Widget build(BuildContext context) {
    
        if(widget.videoFile == null){
          return Center(child: Text("Selecione uma Video"),);
        }
        return SizedBox(
        height: 400,
        width: 300,
        child: Stack(
              children: [
                ClipRRect(
                
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                          child: MyVideoPlayer(videoFile: widget.videoFile!,),
                        ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => widget.onRemoveMedia(widget.videoFile!),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kRed,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
        );
      
  }
}