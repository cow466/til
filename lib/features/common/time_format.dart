import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  if (dateTime.day == DateTime.now().day) {
    return 'Today at ${DateFormat('hh:mm a').format(dateTime)}';
  }
  return 'On ${DateFormat('M/d/y').format(dateTime)} at ${DateFormat('hh:mm a').format(dateTime)}';
}
