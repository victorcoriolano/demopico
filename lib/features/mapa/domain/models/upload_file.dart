class UploadFile {
  final String fileName;
  final String filePath;
  final List<int> bytes;
  final String contentType;

  UploadFile({
    required this.fileName,
    required this.filePath,
    required this.bytes,
    required this.contentType,
  });
}