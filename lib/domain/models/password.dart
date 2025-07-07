class Password {
  final String value;

  Password(this.value) {
    final errorReason = _validate();
    if (errorReason != null) {
      throw ArgumentError(errorReason);
    }
  }

  String? _validate() {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (value.length > 31) {
      return 'Password too large';
    }
    return null;
  }
}
