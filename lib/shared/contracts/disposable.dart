abstract interface class Disposable {
  /// Disposes of the object, releasing any resources it holds.
  ///
  /// This method should be called when the object is no longer needed to free up resources.
  /// It may perform asynchronous operations, so it returns a [Future].
  Future<void> dispose();
}
