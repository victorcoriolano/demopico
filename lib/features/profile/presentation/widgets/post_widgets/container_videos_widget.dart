import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/pages/full_screen_video_page.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/video_player_from_network.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

class ContainerVideosWidget extends StatefulWidget {
  const ContainerVideosWidget({super.key});

  @override
  State<ContainerVideosWidget> createState() => _ContainerVideosWidgetState();
}

class _ContainerVideosWidgetState extends State<ContainerVideosWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      final listRec = provider.fullVideos;
      return listRec.isNotEmpty 
      ? Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 2,
              mainAxisExtent: 100,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, count) {
                if (count < 0 || count >= listRec.length) {
                  return null;
                }
                debugPrint(count.toString());
                return VideoPlayerFromNetwork(
                    url: listRec[count].urlVideos![0]);
              },
            
          ),
          
        ],
      )
      :  const Center(
          child: Text('Nenhuma rec encontrada'),
        );
    });
  }
}
