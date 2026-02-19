abstract class NeuroPredictor {
  Future<Map<String, dynamic>> predict(
    String event,
    Map<String, dynamic> payload,
  );
}
