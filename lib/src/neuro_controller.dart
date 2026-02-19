import 'package:flutter/foundation.dart';
import '../neurostate.dart';

class NeuroController extends ChangeNotifier {
  final NeuroPredictor predictor;

  Map<String, dynamic> _state = {};
  bool _loading = false;

  NeuroController({required this.predictor});

  Map<String, dynamic> get state => _state;
  bool get isLoading => _loading;

  Future<void> dispatch(String event, Map<String, dynamic> payload) async {
    _loading = true;
    notifyListeners();

    try {
      final result = await predictor.predict(event, payload);
      _state.addAll(result);
    } catch (e) {
      debugPrint("NeuroState prediction error: $e");
    }

    _loading = false;
    notifyListeners();
  }

  void reset() {
    _state.clear();
    notifyListeners();
  }
}
