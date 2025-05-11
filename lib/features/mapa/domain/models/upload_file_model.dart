class UploadFileModel {
  final String fileName;
  final String filePath;
  final List<int> bytes;
  final String contentType;

  UploadFileModel({
    required this.fileName,
    required this.filePath,
    required this.bytes,
    required this.contentType,
  });
}