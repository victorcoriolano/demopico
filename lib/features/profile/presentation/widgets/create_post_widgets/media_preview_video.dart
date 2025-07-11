import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/provider/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaPreviewVideo extends StatefulWidget {
  const MediaPreviewVideo({super.key});

  @override
  State<MediaPreviewVideo> createState() => _MediaPreviewVideoState();
}

class _MediaPreviewVideoState extends State<MediaPreviewVideo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, provider, child) {
        if(provider.rec == null){
          return Center(child: Text("Selecione uma Video"),);
        }
        return SizedBox(
        height: 250,
        child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                          child: MyVideoPlayer(videoFile: provider.rec!,),
                        ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => provider.resetVideo,
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
      },
      
    );
  }
}