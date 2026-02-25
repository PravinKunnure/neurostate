import 'predictor.dart';
import 'dart:async';

/// Example state model
class NeuroStateModel {
  final bool typing;
  final bool showRecommendations;
  final bool preloadCheckout;
  final bool prefetchDashboard;

  const NeuroStateModel({
    this.typing = false,
    this.showRecommendations = false,
    this.preloadCheckout = false,
    this.prefetchDashboard = false,
  });

  NeuroStateModel copyWith({
    bool? typing,
    bool? showRecommendations,
    bool? preloadCheckout,
    bool? prefetchDashboard,
  }) {
    return NeuroStateModel(
      typing: typing ?? this.typing,
      showRecommendations: showRecommendations ?? this.showRecommendations,
      preloadCheckout: preloadCheckout ?? this.preloadCheckout,
      prefetchDashboard: prefetchDashboard ?? this.prefetchDashboard,
    );
  }

  @override
  String toString() {
    return '''
NeuroStateModel(
  typing: $typing,
  showRecommendations: $showRecommendations,
  preloadCheckout: $preloadCheckout,
  prefetchDashboard: $prefetchDashboard
)
''';
  }
}

/// Rule-based predictor implementation
class RuleNeuroPredictor implements NeuroPredictor<NeuroStateModel> {
  final NeuroStateModel currentState;

  RuleNeuroPredictor({this.currentState = const NeuroStateModel()});

  @override
  Future<NeuroStateModel> predict(
    String event,
    Map<String, dynamic> payload,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    switch (event) {
      case "open_chat":
        return currentState.copyWith(typing: true);

      case "open_cart":
        return currentState.copyWith(
          showRecommendations: true,
          preloadCheckout: true,
        );

      case "login_success":
        return currentState.copyWith(prefetchDashboard: true);

      default:
        return currentState;
    }
  }
}
