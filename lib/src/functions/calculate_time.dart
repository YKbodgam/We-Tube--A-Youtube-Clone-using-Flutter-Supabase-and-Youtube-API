import 'package:flutter/material.dart';

String timeAgo(String isoString) {
  try {
    DateTime dateTime = DateTime.parse(isoString);
    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inDays >= 365) {
      int years = (diff.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 30) {
      int months = (diff.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 7) {
      int weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  } catch (e) {
    // Handle the case where the input string is not a valid integer
    debugPrint('Error: $e');
    return 'Invalid';
  }
}
