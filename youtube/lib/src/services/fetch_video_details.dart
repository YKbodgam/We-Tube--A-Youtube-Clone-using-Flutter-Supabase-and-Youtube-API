import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';
import '../utils/key.dart';

const String apiKey = youtubeKey;

Future<VideoPreview> fetchVideoDetails(String videoId) async {
  final response = await http.get(
    Uri.parse(
        'https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=$videoId&key=$apiKey'),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    VideoPreview video =
        VideoPreview.fromMap(data['items'][0], data['items'][0]['id']);

    return video;
  } else {
    throw Exception('Failed to load video details');
  }
}
