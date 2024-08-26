// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../classes/video_preview_class.dart';

// final SupabaseClient _client = Supabase.instance.client;

// Future<List<VideoPreview>> fetchVideos() async {
//   try {
//     final response = await _client.from('WeTube_Videos').select();
//     // Check if the response is not empty and is a List
//     if (response.isEmpty) {
//       // Handle the case when no data is returned
//       debugPrint('No user found with the given user ID');
//       return []; // Return empty string or handle error as per your app's logic
//     }

//     return response.map((video) => VideoPreview.fromMap(video)).toList();
//   } catch (error) {
//     debugPrint('Error fetching videos: $error');
//     return [];
//   }
// }
