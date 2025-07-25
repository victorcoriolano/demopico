import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/features/profile/presentation/widgets/create_post_widgets/video_player.dart';
import 'package:flutter/material.dart';

class MediaPreviewList extends StatelessWidget {
  final List<FileModel> mediaPaths;
  final Function(FileModel) onRemoveMedia;

  const MediaPreviewList({
    super.key,
    required this.mediaPaths,
    required this.onRemoveMedia,
  });

  @override
  Widget build(BuildContext context) {
    if (mediaPaths.isEmpty) {
      return const Center(child: Text("Nenhum arquivo selecionado"),);
    }
    return SizedBox(
      height: 120, // Altura fixa para a lista de pré-visualização
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: mediaPaths.length,
        itemBuilder: (context, index) {
          final mediaPath = mediaPaths[index];
          // Uma verificação simples para saber se é imagem ou vídeo
          final isImage = mediaPath.isImage();

          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isImage
                      ? Image.memory(
                          mediaPath.bytes,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.broken_image)),
                        )
                      : Center(
                          child: MyVideoPlayer(videoFile: mediaPath,),
                        ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => onRemoveMedia(mediaPath),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
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
          );
        },
      ),
    );
  }
}