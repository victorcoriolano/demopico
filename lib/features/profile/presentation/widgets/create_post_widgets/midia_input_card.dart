import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:flutter/material.dart';

class MediaInputCard extends StatelessWidget {
  final VoidCallback onAddMedia;
  final TypePost typePost;

  const MediaInputCard({super.key, required this.onAddMedia, required this.typePost});
  
  @override
  Widget build(BuildContext context) {
    final bool isPost = typePost == TypePost.post;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onAddMedia,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isPost ? Icons.add_a_photo: Icons.camera, size: 40, color: Colors.grey),
              SizedBox(height: 8),
              Text(
                isPost ? 'Adicionar Mídia (Foto/Vídeo)' : "Suba aqui sua Rec",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}