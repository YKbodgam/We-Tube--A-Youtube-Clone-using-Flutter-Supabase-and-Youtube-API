class ThumbnailPreview {
  final String thumbnailUrl;
  final String duration;

  ThumbnailPreview(
    this.thumbnailUrl,
    this.duration,
  );

  factory ThumbnailPreview.fromMap(Map<String, dynamic> snippet) {
    final thumbnails = snippet['thumbnails'] as Map<String, dynamic>? ?? {};
    final highThumbnail = thumbnails['high'] as Map<String, dynamic>? ?? {};
    final contentDetails =
        snippet['contentDetails'] as Map<String, dynamic>? ?? {};

    return ThumbnailPreview(
      highThumbnail['url'] as String? ?? '',
      contentDetails['duration'] as String? ?? '',
    );
  }
}
