import '../neurostate.dart';

class RuleNeuroPredictor implements NeuroPredictor {
  @override
  Future<Map<String, dynamic>> predict(
    String event,
    Map<String, dynamic> payload,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    switch (event) {
      case "open_chat":
        return {"typing": true};

      case "open_cart":
        return {"showRecommendations": true, "preloadCheckout": true};

      case "login_success":
        return {"prefetchDashboard": true};

      default:
        return {};
    }
  }
}
