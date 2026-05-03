extension ListExtension<T> on List<T> {
  /// Safe get — returns null instead of throwing RangeError
  /// [1,2,3].safeGet(5) → null
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Splits the list into chunks of the given size
  /// [1,2,3,4,5].chunk(2) → [[1,2],[3,4],[5]]
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size).clamp(0, length)));
    }
    return chunks;
  }

  /// Removes duplicate items
  /// [1,1,2,3,3].unique → [1,2,3]
  List<T> get unique => toSet().toList();
}
