import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/key.dart';
import '../models/comments_model.dart';

const String apiKey = youtubeKey;

Future<List<Comments>> fetchComments(List<String> commentIds) async {
  final List<Comments> comments = [];

  for (String commentId in commentIds) {
    final String url =
        'https://www.googleapis.com/youtube/v3/comments?part=snippet&id=$commentId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Comments comment = Comments.fromMap(data);

      comments.add(comment);
    } else {
      throw Exception('Failed to load comments');
    }
  }
  return comments;
}
