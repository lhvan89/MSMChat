import 'package:intl/intl.dart';

String convertDateToString(DateTime? dateTime, String dateFormat) {
  if (dateTime != null) {
    return DateFormat(dateFormat).format(dateTime);
  } else {
    return "";
  }
}