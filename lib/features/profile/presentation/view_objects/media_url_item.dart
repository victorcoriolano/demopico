
class MediaUrlItem {
  final String url;
  final MediaType contentType;

  MediaUrlItem({
    required this.url,
    required this.contentType,
  });
}

enum MediaType {
  image,
  video,
}