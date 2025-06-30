import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:face_check_in_flutter/domain/entities/network_status.dart';

/// Abstract interface for network connectivity service
abstract class NetworkConnectivityService {
  /// Stream of connectivity changes
  Stream<NetworkStatus> get connectivityStream;

  /// Current connectivity status
  NetworkStatus get currentStatus;

  /// Initialize the connectivity service
  Future<void> initialize();

  /// Manual connectivity check
  Future<NetworkStatus> checkConnectivity();

  /// Dispose resources
  void dispose();
}

/// Network connectivity service implementation for monitoring network connectivity changes
/// Uses connectivity_plus package for cross-platform connectivity monitoring and validates internet access
@LazySingleton(as: NetworkConnectivityService)
class NetworkConnectivityServiceImpl implements NetworkConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final BehaviorSubject<NetworkStatus> _connectivitySubject =
      BehaviorSubject<NetworkStatus>.seeded(NetworkStatus.initial);

  @override
  Stream<NetworkStatus> get connectivityStream => _connectivitySubject.stream;

  @override
  NetworkStatus get currentStatus => _connectivitySubject.value;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  Future<void> initialize() async {
    // Perform an initial check and update the stream.
    // The listener will handle subsequent changes.
    await checkConnectivity();
    _setupConnectivityListener();
  }

  @override
  Future<NetworkStatus> checkConnectivity() async {
    final status = await _performConnectivityCheck();
    if (status != currentStatus) {
      _connectivitySubject.add(status);
    }
    return status;
  }

  void _setupConnectivityListener() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      _,
    ) async {
      // Debounce to avoid rapid changes, then perform a full check.
      await Future.delayed(const Duration(milliseconds: 500));
      await checkConnectivity();
    }, onError: (_) => _connectivitySubject.add(NetworkStatus.disconnected));
  }

  Future<NetworkStatus> _performConnectivityCheck() async {
    try {
      final connectivityResults = await _connectivity.checkConnectivity();
      if (connectivityResults.contains(ConnectivityResult.none)) {
        return NetworkStatus.disconnected;
      }

      // If there's a connection, validate it has internet access.
      final hasInternet = await _validateInternetConnection();
      return hasInternet ? NetworkStatus.connected : NetworkStatus.disconnected;
    } catch (e) {
      return NetworkStatus.disconnected;
    }
  }

  Future<bool> _validateInternetConnection() async {
    try {
      // Use a list of reliable hosts for DNS lookup.
      final hosts = ['google.com', 'cloudflare.com', '1.1.1.1'];
      final lookups = hosts.map((host) => InternetAddress.lookup(host));

      // Wait for any of the lookups to succeed.
      final result = await Future.any(
        lookups,
      ).timeout(const Duration(seconds: 3));

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubject.close();
  }
}
