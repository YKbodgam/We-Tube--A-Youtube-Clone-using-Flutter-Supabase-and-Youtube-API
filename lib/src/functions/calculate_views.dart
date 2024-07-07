import 'package:flutter/material.dart';

String formatViews(String views) {
  int viewsInt;

  try {
    viewsInt = int.parse(views);
  } catch (e) {
    // Handle the case where the input string is not a valid integer
    debugPrint('Error: $e');
    return 'Invalid';
  }

  if (viewsInt >= 1000000) {
    return '${(viewsInt / 1000000).toStringAsFixed(1)}M';
  } else if (viewsInt >= 1000) {
    return '${(viewsInt / 1000).toStringAsFixed(1)}K';
  } else {
    return viewsInt.toString();
  }
}
