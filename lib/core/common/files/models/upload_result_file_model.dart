class UploadStateFileModel {
  final double progress;
  final String? url;
  final UploadState state;

  UploadStateFileModel({
    this.url,
    required this.progress,
    required this.state,
  });

  
}

enum UploadState {
  uploading,
  success,
  failure,
}