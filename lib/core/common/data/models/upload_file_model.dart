import 'dart:typed_data';

class FileModel {
  final String fileName;
  final String? filePath;
  final Uint8List bytes;
  final String contentType;

  FileModel({
    required this.fileName,
    this.filePath,
    required this.bytes,
    required this.contentType,
  });
}