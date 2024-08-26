import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/channel_model.dart';
import '../utils/key.dart';

const String apiKey = youtubeKey;

Future<Channel> fetchChannelDetails(String channelId) async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/youtube/v3/channels?part=snippet&id=$channelId&key=$apiKey'));

  if (response.statusCode == 200) {
    // Get the channel
    Map<String, dynamic> data = json.decode(response.body);
    Channel channel = Channel.fromMap(data);

    return channel;
  } else {
    throw Exception('Failed to load video details');
  }
}
