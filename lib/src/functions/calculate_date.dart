import 'package:intl/intl.dart';

List<String> formatDate(String dateStr) {
  // Parse the input date string to DateTime
  DateTime dateTime = DateTime.parse(dateStr);

  // Define date formatters
  DateFormat monthDayFormatter = DateFormat('MMMM d'); // 'June 9'
  DateFormat yearFormatter = DateFormat('yyyy'); // '2024'

  // Format the date
  String monthDay = monthDayFormatter.format(dateTime);
  String year = yearFormatter.format(dateTime);

  return [monthDay, year];
}
