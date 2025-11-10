import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/post_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/video_player_from_network.dart';
import 'package:flutter/material.dart';

class CardPostWidget extends StatelessWidget {
  final Post post;

  const CardPostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
      }, 
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostWidget(post: post),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: LinearBorder(),
        clipBehavior: Clip.antiAlias,
        child: post.urlImages.isNotEmpty 
          ? Image.network(
            post.urlImages[0],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
          : post.urlVideos != null && post.urlVideos!.isNotEmpty 
            ? VideoPlayerFromNetwork(url: post.urlVideos![0])
            : const Center(
                child: Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }
}
