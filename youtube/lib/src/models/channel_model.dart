class Channel {
  final String id;
  final String title;
  final String description;
  final String profilePictureUrl;

  final String subscriberCount;
  final String createdAt;

  Channel(
    this.id,
    this.title,
    this.description,
    this.profilePictureUrl,
    this.subscriberCount,
    this.createdAt,
  );

  factory Channel.fromMap(Map<String, dynamic> snippet) {
    final items = snippet['items'] as List<dynamic>? ?? [];

    // Create a new list  with item[0]
    final firstItem =
        items.isNotEmpty ? items[0] as Map<String, dynamic>? ?? {} : {};

    // Create a new list with item[0][snippet]
    final snippetMap = firstItem['snippet'] as Map<String, dynamic>? ?? {};

    // Create a new list with item[0][snippet][thumbnail][high]
    final thumbnails = snippetMap['thumbnails'] as Map<String, dynamic>? ?? {};
    final highResThumbnail = thumbnails['high'] as Map<String, dynamic>? ?? {};

    final statistics = firstItem['statistics'] as Map<String, dynamic>? ?? {};

    return Channel(
      firstItem['id'] as String? ?? '',
      snippetMap['title'] as String? ?? '',
      snippetMap['description'] as String? ?? '',
      highResThumbnail['url'] as String? ?? '',
      statistics['subscriberCount'] ?? '0',
      snippetMap['publishedAt'] as String? ?? '',
    );
  }
}
