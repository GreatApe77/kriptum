abstract interface class Initializable {
  /// Initializes the object.
  ///
  /// This method should be called before using the object to ensure it is properly set up.
  /// It may perform asynchronous operations, so it returns a [Future].
  Future<void> initialize();
}