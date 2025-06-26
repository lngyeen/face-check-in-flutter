import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

/// Abstract interface for network connectivity service
abstract class NetworkConnectivityService {
  /// Stream of connectivity changes (true = connected, false = disconnected)
  Stream<bool> get connectivityStream;

  /// Current connectivity status
  bool get isConnected;

  /// Initialize the connectivity service
  Future<void> initialize();

  /// Manual connectivity check (useful for user-triggered retries)
  Future<bool> checkConnectivity();

  /// Dispose resources
  void dispose();
}

/// Network connectivity service implementation for monitoring network connectivity changes
/// Uses connectivity_plus package for cross-platform connectivity monitoring and validates internet access
@LazySingleton(as: NetworkConnectivityService)
class NetworkConnectivityServiceImpl implements NetworkConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final BehaviorSubject<bool> _connectivitySubject =
      BehaviorSubject<bool>.seeded(false);

  /// Stream of connectivity changes (true = connected, false = disconnected)
  @override
  Stream<bool> get connectivityStream => _connectivitySubject.stream;

  /// Current connectivity status
  @override
  bool get isConnected => _connectivitySubject.value;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// Initialize the connectivity service and start monitoring
  @override
  Future<void> initialize() async {
    final initialConnectivity = await _checkConnectivity();
    _connectivitySubject.add(initialConnectivity);
    _setupConnectivityListener();
  }

  /// Manual connectivity check (useful for user-triggered retries)
  /// Returns true if internet connection is available
  @override
  Future<bool> checkConnectivity() async {
    final isConnected = await _checkConnectivity();
    _connectivitySubject.add(isConnected);
    return isConnected;
  }

  /// Setup connectivity listener for automatic monitoring
  void _setupConnectivityListener() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (error) {
        _connectivitySubject.add(false);
      },
    );
  }

  /// Check connectivity status and validate internet access
  Future<bool> _checkConnectivity() async {
    try {
      final connectivityResults = await _connectivity.checkConnectivity();

      if (connectivityResults.contains(ConnectivityResult.none)) {
        return false;
      }

      return await _validateInternetConnection();
    } catch (e) {
      return false;
    }
  }

  /// Validate internet connection by attempting DNS lookups
  Future<bool> _validateInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      try {
        final result = await InternetAddress.lookup(
          'cloudflare.com',
        ).timeout(const Duration(seconds: 3));
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (e) {
        return false;
      }
    }
  }

  /// Handle connectivity changes with debouncing
  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final isConnected = await _checkConnectivity();
    _connectivitySubject.add(isConnected);
  }

  /// Dispose resources and cancel subscriptions
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubject.close();
  }
}
