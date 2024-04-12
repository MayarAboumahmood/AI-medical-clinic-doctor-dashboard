import 'package:intl/intl.dart';

class DateFormatter {
  // Formats a DateTime object into a date string.
 static String formatDate(DateTime dateTime) {
    // You can customize the date format string as needed
    // DateFormat dateFormat = DateFormat('yyyy-MM-dd');
     DateFormat dateFormat = DateFormat('EEE dd MMM ');
    // DateFormat dateFormat = DateFormat.();
    return dateFormat.format(dateTime);
  }

  // Formats a DateTime object into a time string.
  static String formatTime(DateTime dateTime) {
    // You can customize the time format string as needed
    DateFormat timeFormat = DateFormat('HH:mm a');
    return timeFormat.format(dateTime);
  }
  static String getYear(DateTime dateTime) {
  // Define the date format to extract only the year
  DateFormat yearFormat = DateFormat('yyyy');
  return yearFormat.format(dateTime);
}
}
