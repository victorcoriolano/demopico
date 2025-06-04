class UploadResultFileModel {
  final Stream<double> progress;
  final Future<String> url;

  UploadResultFileModel({
    required this.progress,
    required this.url,
  });
}