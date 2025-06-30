class Mnemonic {
  final String phrase;

  Mnemonic(this.phrase) {
    final errorReason = _validate();
    if (errorReason != null) {
      throw ArgumentError(errorReason);
    }
  }

  String? _validate() {
    if (phrase.isEmpty) {
      return 'Mnemonic phrase cannot be empty';
    }
    if (phrase.split(' ').length != 12) {
      return 'Mnemonic phrase must contain 12 words';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(phrase)) {
      return 'Mnemonic phrase can only contain letters and spaces';
    }
    return null;
  }
}
