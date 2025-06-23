class DomainException implements Exception {
  final String _reason;
  DomainException(String reason) : _reason = reason;

  String getReason() => _reason;
}
