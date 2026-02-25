//neuro_controller.dart
import 'package:flutter/foundation.dart';
import 'predictor.dart';

class NeuroController<T> extends ChangeNotifier {
  final NeuroPredictor<T> predictor;

  T _state;
  bool _loading = false;
  Object? _error;

  NeuroController({required this.predictor, required T initialState})
    : _state = initialState;

  /// Current state
  T get state => _state;

  /// Loading status
  bool get isLoading => _loading;

  /// Error from last prediction
  Object? get error => _error;

  /// Dispatch an event to predictor
  Future<void> dispatch(String event, Map<String, dynamic> payload) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final newState = await predictor.predict(event, payload);
      _state = newState;
    } catch (e) {
      _error = e;
      debugPrint("NeuroState prediction error: $e");
    }

    _loading = false;
    notifyListeners();
  }

  /// Preview predicted state without committing
  Future<T> preview(String event, Map<String, dynamic> payload) {
    return predictor.predict(event, payload);
  }

  /// Manually update state (advanced usage)
  void setState(T newState) {
    _state = newState;
    notifyListeners();
  }

  /// Reset state
  void reset(T newState) {
    _state = newState;
    _error = null;
    notifyListeners();
  }
}
