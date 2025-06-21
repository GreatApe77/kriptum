class Result<Value, Failure> {
  final Value? value;
  final Failure? failure;

  Result({this.value, this.failure});

  bool get isSuccess => value != null;

  bool get isFailure => failure != null;

  factory Result.success(Value value) {
    return Result<Value, Failure>(value: value, failure: null);
  }

  factory Result.failure(Failure failure) {
    return Result<Value, Failure>(value: null, failure: failure);
  }
}
