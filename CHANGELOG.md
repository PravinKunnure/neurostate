# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)  
and this project adheres to [Semantic Versioning](https://semver.org/).

---

## [0.1.1] - 2026-02-25
- Doc Changes


## [0.1.0] - 2026-02-25

### Added
- Strongly typed generic `NeuroController<T>`
- Generic `NeuroPredictor<T>` interface
- Typed state model support (no more dynamic Map-based state)
- Built-in loading state handling (`isLoading`)
- Built-in error handling (`error`)
- `preview()` method for non-committed predictive state evaluation
- `setState()` method for controlled manual state updates
- Improved example application with typed architecture

### Changed
- Replaced dynamic `Map<String, dynamic>` state with strongly typed state model
- Improved controller architecture for better scalability
- Enhanced internal state safety and predictability
- Updated README with full typed usage documentation

### Improved
- Cleaner API design
- Better separation of concerns between controller and predictor
- More production-ready structure
- Improved extensibility for future AI/LLM integrations

### Notes
This release transitions NeuroState from an experimental prototype to a production-ready, strongly-typed predictive state management architecture for Flutter.

---

## [0.0.1] - Initial Release

### Added
- Core `NeuroController` for predictive state management
- `NeuroPredictor` interface for pluggable AI logic
- `RuleNeuroPredictor` for offline intelligent predictions
- Event-driven predictive state dispatching
- Example Flutter demo showcasing NeuroState usage

### Notes
Initial experimental release introducing AI-augmented state management concept for Flutter apps.