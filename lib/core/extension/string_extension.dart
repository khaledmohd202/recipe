extension StringExtension on String {
  /// 'hello world' → 'Hello world'
  String toCapitalized() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// 'hello world' → 'Hello World'
  String toTitleCase() {
    return split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return '${word[0].toUpperCase()}${word.substring(1)}';
        })
        .join(' ');
  }

  /// 'hello@email.com' → true
  bool get isValidEmail {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(
      r'^('
      // Egypt
      r'01[0125][0-9]{8}|'
      r'\+201[0125][0-9]{8}|'
      // KSA / Emirates
      r'05[0-9]{8}|'
      r'\+9665[0-9]{8}|'
      r'\+9715[0-9]{8}|'
      // Kuwait
      r'[56][0-9]{7}|'
      r'\+965[56][0-9]{7}|'
      // Qatar
      r'[3-7][0-9]{7}|'
      r'\+974[3-7][0-9]{7}|'
      // Bahrain
      r'3[0-9]{7}|'
      r'\+9733[0-9]{7}|'
      // Oman
      r'[79][0-9]{7}|'
      r'\+968[79][0-9]{7}'
      r')$',
    ).hasMatch(replaceAll(' ', ''));
  }

  /// '  hello  ' → 'hello'
  String get trimmed => trim();

  /// '' → true
  bool get isNullOrEmpty => isEmpty;

  /// 'Hello World' → true
  bool get isNotNullOrEmpty => isNotEmpty;
}
