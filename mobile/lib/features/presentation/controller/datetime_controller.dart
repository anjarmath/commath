import 'package:intl/intl.dart';

class DatetimeController {
  static String formatDatetime(String datetime) {
    try {
      return DateFormat('dd MMM yyyy • HH:mm', 'id_ID')
          .format(DateTime.parse(datetime).toLocal());
    } catch (e) {
      print(datetime);
      return '?';
    }
  }
}
