import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/view_model/post_provider.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/video_player_from_network.dart';
import 'package:flutter/material.dart';
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
      return Stack(
        children: [
          ListWheelScrollView.useDelegate(
            itemExtent: 350,
            diameterRatio: 0.8,
            physics: FixedExtentScrollPhysics(),
            perspective: 0.0009,
            onSelectedItemChanged: (index) {},
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, count) {
                if (count < 0 || count >= listRec.length) {
                  return null;
                }
                debugPrint(count.toString());
                return VideoPlayerFromNetwork(
                    url: listRec[count].urlVideos![0]);
              },
              childCount: listRec.length,
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.fullscreen,
                color: kWhite,
              ),
            ),
          ),
        ],
      );
    });
  }
}
