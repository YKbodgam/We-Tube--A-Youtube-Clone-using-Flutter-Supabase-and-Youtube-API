import 'package:flutter/material.dart';
import 'package:youtube/src/services/fetch_comments_details.dart';

import 'comments_model.dart';
import 'thumbnail_model.dart';
import '../services/fetch_comment_ids.dart';

class VideoPreview {
  final String videoId;
  final String channelId;
  final ThumbnailPreview thumbnail;

  final String title;
  final String description;
  final String publishedAt;

  final List<String> tags;
  List<Comments> comments = [];

  final String viewsCount;
  final String likesCount;
  final String commentsCount;

  VideoPreview(
    this.videoId,
    this.channelId,
    this.thumbnail,
    this.title,
    this.description,
    this.publishedAt,
    this.tags,
    this.viewsCount,
    this.likesCount,
    this.commentsCount,
  ) {
    getComments();
  }

  Future<void> getComments() async {
    try {
      final commentIds = await fetchCommentIds(videoId);

      if (commentIds.isNotEmpty) {
        //
        final comment = await fetchComments(commentIds);
        comments.addAll(comment);
      }
    } catch (e) {
      debugPrint('Error fetching comments: $e');
    }
  }

  factory VideoPreview.fromMap(Map<String, dynamic> snippet, String? id) {
    final snippetMap = snippet['snippet'] as Map<String, dynamic>? ?? {};
    final statistics = snippet['statistics'] as Map<String, dynamic>? ?? {};

    return VideoPreview(
      id ?? snippet['id'] as String? ?? '',
      snippetMap['channelId'] as String? ?? '',
      ThumbnailPreview.fromMap(snippetMap),
      snippetMap['title'] as String? ?? '',
      snippetMap['description'] as String? ?? '',
      snippetMap['publishedAt'] as String? ?? '',
      List<String>.from(snippetMap['tags'] ?? []),
      statistics['viewCount'] as String? ?? '',
      statistics['likeCount'] as String? ?? '',
      statistics['commentCount'] as String? ?? '',
    );
  }
}
