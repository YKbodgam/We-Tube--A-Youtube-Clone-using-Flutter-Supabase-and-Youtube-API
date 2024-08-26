import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';
import '../utils/key.dart';

const String apiKey = youtubeKey;

Future<Map<String, List<VideoPreview>>> fetchCategoryVideos() async {
  final Map<String, List<VideoPreview>> categoryVideos = {
    '10': [],
    '17': [],
    '19': [],
    '20': [],
    '24': [],
    '25': [],
  };

  for (String category in categoryVideos.keys) {
    final String url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&videoCategoryId=$category&type=video&key=$apiKey&maxResults=2';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      final List<VideoPreview> videos = items.map((item) {
        return VideoPreview.fromMap(item, item['id']['videoId']);
      }).toList();

      categoryVideos[category] = videos;
    } else {
      throw Exception('Failed to load Category videos');
    }
  }

  return categoryVideos;
}
