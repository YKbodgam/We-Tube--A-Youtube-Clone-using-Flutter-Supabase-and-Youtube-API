import 'dart:convert';

import '../utils/key.dart';
import 'package:http/http.dart' as http;

const String apiKey = youtubeKey;

Future<List<String>> fetchCommentIds(String videoId) async {
  final String url =
      'https://www.googleapis.com/youtube/v3/commentThreads?part=id&videoId=$videoId&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> items = data['items'];

    List<String> commentIds =
        items.map((item) => item['id'] as String).toList();
    return commentIds;
  } else {
    throw Exception('Failed to load comment IDs');
  }
}
