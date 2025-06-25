import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// Service for monitoring network connectivity changes
@singleton
class NetworkConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamController<bool>? _connectivityStreamController;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool _isConnected = false;
  bool _isInitialized = false;

  /// Initialize the service and start monitoring connectivity
  Future<void> initialize() async {
    if (_isInitialized) return;

    _connectivityStreamController = StreamController<bool>.broadcast();

    // Check initial connectivity
    _isConnected = await _checkConnectivity();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (error) {
        // Handle connectivity stream errors gracefully
      },
    );

    _isInitialized = true;
  }

  /// Stream of connectivity changes (true = connected, false = disconnected)
  Stream<bool> get connectivityStream {
    if (!_isInitialized) {
      throw StateError('NetworkConnectivityService not initialized');
    }
    return _connectivityStreamController!.stream;
  }

  /// Current connectivity status
  bool get isConnected => _isConnected;

  /// Check current connectivity with actual internet validation
  Future<bool> _checkConnectivity() async {
    try {
      final connectivityResults = await _connectivity.checkConnectivity();

      // If no connectivity at all, return false immediately
      if (connectivityResults.contains(ConnectivityResult.none)) {
        return false;
      }

      // If we have connectivity, validate with actual internet check
      return await _validateInternetConnection();
    } catch (e) {
      return false;
    }
  }

  /// Validate actual internet connection by attempting to reach a reliable host
  Future<bool> _validateInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      try {
        // Fallback to another reliable host
        final result = await InternetAddress.lookup(
          'cloudflare.com',
        ).timeout(const Duration(seconds: 3));
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (e) {
        return false;
      }
    }
  }

  /// Handle connectivity changes from the connectivity stream
  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
    // Add small delay to allow network to stabilize
    await Future.delayed(const Duration(milliseconds: 100));

    final wasConnected = _isConnected;
    _isConnected = await _checkConnectivity();

    // Only emit if connectivity actually changed
    if (wasConnected != _isConnected) {
      _connectivityStreamController?.add(_isConnected);
    }
  }

  /// Manual connectivity check (useful for user-triggered retries)
  Future<bool> checkConnectivity() async {
    final wasConnected = _isConnected;
    _isConnected = await _checkConnectivity();

    // Emit change if status changed
    if (wasConnected != _isConnected) {
      _connectivityStreamController?.add(_isConnected);
    }

    return _isConnected;
  }

  /// Dispose the service
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivityStreamController?.close();
  }
}
