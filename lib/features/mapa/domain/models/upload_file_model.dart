import 'dart:typed_data';

class UploadFileModel {
  final String fileName;
  final String? filePath;
  final Uint8List bytes;
  final String contentType;

  UploadFileModel({
    required this.fileName,
    this.filePath,
    required this.bytes,
    required this.contentType,
  });
}