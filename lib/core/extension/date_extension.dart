import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  /// 05-03-2026
  String get formattedDayMonthYear => DateFormat('dd-MM-yyyy').format(this);

  /// 5 Mar, 2026
  String get formattedReadable => DateFormat('d MMM, y').format(this);

  /// 5 Mar, 2026 - 3:00 PM
  String get formattedWithTime => DateFormat('d MMM, y - h:mm a').format(this);

  /// current day == today
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  /// current day == yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year;
  }

  /// Today / Yesterday / 5 Mar, 2026
  String get smartFormat {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    return formattedReadable;
  }
}
