import 'dart:typed_data';

class FileModel {
  final String fileName;
  final String? filePath;
  final Uint8List bytes;
  final ContentType contentType;

  FileModel({
    required this.fileName,
    this.filePath,
    required this.bytes,
    required this.contentType,
  });

  bool isImage(){
    return contentType.isImage; 
  }

}


enum ContentType {
  jpg,
  jpeg,
  png,
  heic,     // Fotos recentes de iPhone (não pode faltar)
  mp4,      // Vídeo padrão Android/Web
  mov,      // Vídeo padrão iOS (MUUUITO importante!)
  mp3,      // Áudio mais comum
  unavailable; // Tipo de arquivo não suportado ou desconhecido
}


extension ContentTypeExtension on ContentType { 
  static ContentType fromMime(String mime) {
    if (mime.startsWith('image/')) {
      if (mime.contains('jpeg')) return ContentType.jpeg;
      if (mime.contains('jpg')) return ContentType.jpg;
      if (mime.contains('png')) return ContentType.png;
      if (mime.contains('heic')) return ContentType.heic;
    }

    if (mime.startsWith('video/')) {
      if (mime.contains('mp4')) return ContentType.mp4;
      if (mime.contains('quicktime')) return ContentType.mov; // MOV
    }

    if (mime.startsWith('audio/')) {
      if (mime.contains('mp3')) return ContentType.mp3;
    }

    return ContentType.unavailable;
  }

  bool get isImage => [
    ContentType.jpg,
    ContentType.jpeg,
    ContentType.png,
    ContentType.heic,
  ].contains(this);

  bool get isVideo => [
    ContentType.mp4,
    ContentType.mov,
  ].contains(this);

  bool get isAudio => this == ContentType.mp3;

}
