import 'package:flutter/material.dart';
import 'package:neurostate/neurostate.dart';

void main() {
  runApp(const MyApp());
}

/// ----------------------------
/// 1️⃣ STATE MODEL
/// ----------------------------
class AppState {
  final bool typing;
  final bool showRecommendations;
  final bool preloadCheckout;
  final bool prefetchDashboard;

  const AppState({
    this.typing = false,
    this.showRecommendations = false,
    this.preloadCheckout = false,
    this.prefetchDashboard = false,
  });

  AppState copyWith({
    bool? typing,
    bool? showRecommendations,
    bool? preloadCheckout,
    bool? prefetchDashboard,
  }) {
    return AppState(
      typing: typing ?? this.typing,
      showRecommendations: showRecommendations ?? this.showRecommendations,
      preloadCheckout: preloadCheckout ?? this.preloadCheckout,
      prefetchDashboard: prefetchDashboard ?? this.prefetchDashboard,
    );
  }

  @override
  String toString() {
    return '''
AppState(
  typing: $typing,
  showRecommendations: $showRecommendations,
  preloadCheckout: $preloadCheckout,
  prefetchDashboard: $prefetchDashboard
)
''';
  }
}

/// ----------------------------
/// 2️⃣ PREDICTOR
/// ----------------------------
class RulePredictor implements NeuroPredictor<AppState> {
  AppState _currentState = const AppState();

  @override
  Future<AppState> predict(String event, Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(milliseconds: 500));

    switch (event) {
      case "open_chat":
        _currentState = _currentState.copyWith(typing: true);
        break;

      case "open_cart":
        _currentState = _currentState.copyWith(
          showRecommendations: true,
          preloadCheckout: true,
        );
        break;

      case "login_success":
        _currentState = _currentState.copyWith(prefetchDashboard: true);
        break;

      case "reset":
        _currentState = const AppState();
        break;
    }

    return _currentState;
  }
}

/// ----------------------------
/// 3️⃣ APP ROOT
/// ----------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuroState Example',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

/// ----------------------------
/// 4️⃣ HOME PAGE
/// ----------------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NeuroController<AppState> controller;

  @override
  void initState() {
    super.initState();
    controller = NeuroController<AppState>(
      predictor: RulePredictor(),
      initialState: const AppState(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _dispatch(String event) {
    controller.dispatch(event, {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NeuroState Demo")),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final state = controller.state;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Loading Indicator
                if (controller.isLoading) const LinearProgressIndicator(),

                const SizedBox(height: 16),

                /// Error Display
                if (controller.error != null)
                  Text(
                    "Error: ${controller.error}",
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 16),

                /// Predictive UI
                if (state.typing)
                  const Text(
                    "💬 AI is typing...",
                    style: TextStyle(fontSize: 18),
                  ),

                if (state.showRecommendations)
                  const Text(
                    "🛍 Showing smart recommendations",
                    style: TextStyle(fontSize: 18),
                  ),

                if (state.preloadCheckout)
                  const Text(
                    "⚡ Checkout preloaded",
                    style: TextStyle(fontSize: 18),
                  ),

                if (state.prefetchDashboard)
                  const Text(
                    "📊 Dashboard prefetched",
                    style: TextStyle(fontSize: 18),
                  ),

                const Spacer(),

                /// Buttons
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () => _dispatch("open_chat"),
                      child: const Text("Open Chat"),
                    ),
                    ElevatedButton(
                      onPressed: () => _dispatch("open_cart"),
                      child: const Text("Open Cart"),
                    ),
                    ElevatedButton(
                      onPressed: () => _dispatch("login_success"),
                      child: const Text("Login Success"),
                    ),
                    ElevatedButton(
                      onPressed: () => _dispatch("reset"),
                      child: const Text("Reset"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
