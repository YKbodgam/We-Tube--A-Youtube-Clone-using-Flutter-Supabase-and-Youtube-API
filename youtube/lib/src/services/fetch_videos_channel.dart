import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube/src/services/fetch_video_details.dart';

import '../utils/key.dart';

const String apiKey = youtubeKey;

Future<List<dynamic>> fetchNewerVideoIds(String channelId) async {
  final String url =
      'https://www.googleapis.com/youtube/v3/search?part=id&channelId=$channelId&order=date&type=video&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  List<dynamic> details = [];

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> items = data['items'];

    List<String> videoIds =
        items.map((item) => item['id']['videoId'] as String).toList();

    for (String id in videoIds) {
      details.add(
        await fetchVideoDetails(id),
      );
    }

    return details;
  } else {
    throw Exception('Failed to load video IDs');
  }
}
