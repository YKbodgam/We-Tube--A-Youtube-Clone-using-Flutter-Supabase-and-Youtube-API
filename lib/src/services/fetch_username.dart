import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient _client = Supabase.instance.client;

Future<String> fetchUsernameFromSupabase(String creatorId) async {
  try {
    final response =
        await _client.from('WeTube_Users').select().eq('user_id', creatorId);

    if (response.isEmpty) {
      // Handle the case when no data is returned
      debugPrint('No user found with the given user ID');
      return ''; // Return empty string or handle error as per your app's logic
    }

    return response[0]['username'];
  } catch (e) {
    // Handle any other type of exception
    debugPrint('Error fetching username: $e');
    return ''; // Return empty string or handle error as per your app's logic
  }
}
