# Face Check-In Flutter Project Structure

## 1. Introduction

This document describes the standard directory structure for the Face Check-In Flutter application. The structure is organized primarily by **Clean Architecture layers** (`domain`, `data`, `presentation`) and secondarily by feature. This approach is chosen to clearly delineate architectural boundaries, enhance maintainability, and support future dependency injection.

**Date:** July 26, 2024
**Version:** 1.0
**Author:** David, Flutter Dev

## 2. Guiding Principles

- **Layer-First (Clean Architecture):** The primary organization under `lib/` directly reflects the Clean Architecture layers.
- **Feature Grouping within Layers:** Code related to specific features will be grouped together as subdirectories within each appropriate layer.
- **Clarity & Convention:** Use clear and consistent naming for directories and files.
- **Testability:** The structure of the `test/` directory **MUST** mirror the `lib/` directory structure to make tests easy to locate and ensure complete coverage.
- **Dependency Rule Enforcement:** The directory structure should visually reinforce the Clean Architecture dependency rule (dependencies flow inwards: Presentation → Domain, Data → Domain).

## 3. Top-Level Directory Structure

```
face-check-in-flutter/
├── android/
├── ios/
├── lib/                          # Main Dart application code (detailed below)
├── test/                         # Unit and widget tests (mirrors /lib)
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

## 4. `lib/` Directory Structure

The `lib/` directory is the heart of the application, containing all Dart code.

```
lib/
├── app/                          # Root application widget and BLoC observer setup
├── core/                         # Cross-cutting concerns & framework setup
│   ├── services/                 # Cross-cutting services (e.g., WebSocketService)
│   └── ...                       # Other core modules like constants, utils, etc.
│
├── features/                     # Feature-based modules (UI and BLoC logic)
│   └── [feature_name]/           # e.g., check_in
│       ├── bloc/                 # BLoCs or Cubits for state management
│       ├── view/                 # Feature-specific full screens/pages
│       └── widgets/              # UI components specific to this feature
│
├── data/                         # Data Layer: implements repository interfaces, data sources
│   └── ...
│
└── domain/                       # Domain Layer: Pure business logic (entities, usecases, repository interfaces)
    └── ...
```

## 5. `test/` Directory Structure

The `test/` directory **MUST** mirror the `lib/` structure precisely. This ensures that for any file in `lib/`, its corresponding test file can be found at the exact same path under `test/`.

**Example:**
- A service at `lib/core/services/websocket_service.dart`
- Will have its test file at `test/core/services/websocket_service_test.dart`.

- A screen at `lib/features/check_in/view/check_in_screen.dart`
- Will have its widget test at `test/features/check_in/view/check_in_screen_test.dart`.

```
test/
├── core/
│   └── services/
│       └── websocket_service_test.dart
│
└── features/
    └── check_in/
        └── view/
            └── check_in_screen_test.dart
```

This structure makes navigation intuitive and enforces a clear testing strategy.
