import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityExampleScreen extends StatefulWidget {
  const ConnectivityExampleScreen({super.key});

  @override
  State<ConnectivityExampleScreen> createState() => _ConnectivityExampleScreenState();
}

class _ConnectivityExampleScreenState extends State<ConnectivityExampleScreen> {
  String connectionStatus = 'Memuat...';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    checkConnection();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> checkConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      setState(() {
        connectionStatus = 'Gagal mendapatkan status koneksi';
      });
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          connectionStatus = 'Terhubung ke Wi-Fi';
          break;
        case ConnectivityResult.mobile:
          connectionStatus = 'Terhubung ke jaringan Mobile';
          break;
        case ConnectivityResult.ethernet:
          connectionStatus = 'Terhubung ke Ethernet';
          break;
        case ConnectivityResult.bluetooth:
          connectionStatus = 'Terhubung ke Bluetooth';
          break;
        case ConnectivityResult.none:
          connectionStatus = 'Tidak ada koneksi internet';
          break;
        default:
          connectionStatus = 'Status koneksi tidak diketahui';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Koneksi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              connectionStatus,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkConnection,
              child: const Text('Periksa Koneksi'),
            ),
          ],
        ),
      ),
    );
  }
}