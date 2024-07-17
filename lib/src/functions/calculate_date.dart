import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> formatDate(String dateStr) {
  // Parse the input date string to DateTime
  try {
    DateTime dateTime = DateTime.parse(dateStr);

    // Define date formatters
    DateFormat monthDayFormatter = DateFormat('MMMM d'); // 'June 9'
    DateFormat yearFormatter = DateFormat('yyyy'); // '2024'

    // Format the date
    String monthDay = monthDayFormatter.format(dateTime);
    String year = yearFormatter.format(dateTime);

    return [monthDay, year];
  } catch (e) {
    // Handle the case where the input string is not a valid integer
    debugPrint('Error: $e');
    return [];
  }
}
