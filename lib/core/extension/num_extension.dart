extension NumExtension on num {
  /// 1000 → '1,000'
  String get formatted {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  /// 1500 → '1.5K'  |  1000000 → '1M'
  String get compacted {
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    if (this >= 1000) return '${(this / 1000).toStringAsFixed(1)}K';
    return toString();
  }

  /// 5 → Duration(seconds: 5)
  Duration get seconds => Duration(seconds: toInt());

  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get minutes => Duration(minutes: toInt());
}
