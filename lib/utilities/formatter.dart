import 'package:intl/intl.dart';

String getDateTime(String? value) {
  return value == null
      ? '-'
      : DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.parse(value).toLocal());
}

String? getDistanceKM(double? value) {
  return value == null ? null : '${(value / 100).round() / 10}km';
}
