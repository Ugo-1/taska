import 'package:taska/extensions/extension_exports.dart';

extension DayOfWeekExtension on int {
  DateTime nextInstanceOfDayOfWeek() {
    final DateTime now = DateTime.now();
    int daysToAdd = this - now.weekday;
    if (daysToAdd < 0) {
      daysToAdd += 7;
    }
    return now.add(Duration(days: daysToAdd));
  }

  String getDayOfWeekText([String pattern = 'EEE']) {
    final targetDate = nextInstanceOfDayOfWeek();
    return targetDate.formatDate(pattern);
  }
}
