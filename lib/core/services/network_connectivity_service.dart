import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

/// Service for monitoring network connectivity changes
@lazySingleton
class NetworkConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final BehaviorSubject<bool> _connectivitySubject =
      BehaviorSubject<bool>.seeded(false);

  /// Stream of connectivity changes (true = connected, false = disconnected)
  Stream<bool> get connectivityStream => _connectivitySubject.stream;

  /// Current connectivity status
  bool get isConnected => _connectivitySubject.value;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  Future<void> initialize() async {
    final initialConnectivity = await _checkConnectivity();
    _connectivitySubject.add(initialConnectivity);
    _setupConnectivityListener();
  }

  /// Manual connectivity check (useful for user-triggered retries)
  Future<bool> checkConnectivity() async {
    final isConnected = await _checkConnectivity();
    _connectivitySubject.add(isConnected);
    return isConnected;
  }

  void _setupConnectivityListener() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (error) {
        _connectivitySubject.add(false);
      },
    );
  }

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

  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final isConnected = await _checkConnectivity();
    _connectivitySubject.add(isConnected);
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubject.close();
  }
}
