import 'package:kriptum/shared/utils/result.dart';

/// A factory interface that defines a method to create an instance of type V
/// based on an input of type I, returning a Result that can either be a success
/// with a value of type V or a failure with a value of type F.
abstract interface class Factory<I, V, F> {
  ///
  /// V -> The type of the value that the factory will create.
  ///
  /// I -> The type of the input that the factory will use to create the value.
  ///
  /// F -> The type of the failure that the factory might return.
  ///
  Result<V, F> create(I input);
}
