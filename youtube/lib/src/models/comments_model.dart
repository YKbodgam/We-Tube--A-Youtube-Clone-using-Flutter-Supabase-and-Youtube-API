class Comments {
  final String commentId;
  final String authorName;
  final String authorProfile;
  final String comment;

  final int likeCount;
  final String publisedAt;

  Comments(
    this.commentId,
    this.authorName,
    this.authorProfile,
    this.comment,
    this.likeCount,
    this.publisedAt,
  );

  factory Comments.fromMap(Map<String, dynamic> snippet) {
    final items = snippet['items'] as List<dynamic>? ?? [];

    // Create a new list  with item[0]
    final firstItem =
        items.isNotEmpty ? items[0] as Map<String, dynamic>? ?? {} : {};

    // Create a new list with item[0][snippet]
    final snippetMap = firstItem['snippet'] as Map<String, dynamic>? ?? {};

    return Comments(
      firstItem['id'] as String? ?? '',
      snippetMap['authorDisplayName'] as String? ?? '',
      snippetMap['authorProfileImageUrl'] as String? ?? '',
      snippetMap['textDisplay'] as String? ?? '',
      snippetMap['likeCount'] as int? ?? 0,
      snippetMap['publishedAt'] as String? ?? '',
    );
  }
}
