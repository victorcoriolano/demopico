import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/presentation/widgets/post_widgets/post_widget.dart';
import 'package:flutter/material.dart';

class CardPostWidget extends StatelessWidget {
  final Post post;

  const CardPostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    String cardPhoto = post.urlMidia[0];

    bool isVideo = post.files!.any((file) => file.contentType.isVideo);

    return GestureDetector(
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        clipBehavior: Clip.antiAlias,
        child: isVideo 
          ? Image.network(
            cardPhoto,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
          : Center(child: SizedBox.shrink(),)
      ),
    );
  }
}
