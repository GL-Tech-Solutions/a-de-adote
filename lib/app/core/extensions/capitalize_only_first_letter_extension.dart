extension CapitalizeOnlyFirstLetterExtension on String {
  String get stringAdjusted {
    final String word;
    word = this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase();

    return word;
  }
}
