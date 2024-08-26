// ignore_for_file: unused_local_variable

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final YoutubeExplode _youtubeExplode = YoutubeExplode();

Future<String> getVideoUrl(String videoId) async {
  // video is an instance of Video, which holds the video metadata.
  var video = await _youtubeExplode.videos.get(videoId);

  // This line fetches the stream manifest for the video, which contains information about the available streams
  var manifest = await _youtubeExplode.videos.streamsClient.getManifest(
    videoId,
  );

  // Muxed streams contain both audio and video in a single file.
  var streamInfo = manifest.muxed.withHighestBitrate();

  return streamInfo.url.toString();
}
