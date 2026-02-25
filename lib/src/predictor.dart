/// Base contract for all NeuroState predictors.
///
/// T represents the state type.
abstract class NeuroPredictor<T> {
  Future<T> predict(String event, Map<String, dynamic> payload);
}
