import 'dart:async';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'sensor_example_screen.dart'; // sesuaikan dengan path Anda

class InfoDeviceScreen extends StatefulWidget {
  const InfoDeviceScreen({super.key});

  @override
  State<InfoDeviceScreen> createState() => _InfoDeviceScreenState();
}

class _InfoDeviceScreenState extends State<InfoDeviceScreen> {
  String deviceName = '-';
  String osVersion = '-';
  String model = '-';
  String brand = '-';
  String connectionStatus = 'Memuat...';
  String sensorStatus = 'Tidak Aktif';
  String movementStatus = 'Tidak bergerak';
  bool isSensorActive = false;

  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
    getConnectionStatus();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  Future<void> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceName = androidInfo.device ?? '-';
          osVersion = 'Android ${androidInfo.version.release ?? '-'}';
          model = androidInfo.model ?? '-';
          brand = androidInfo.brand ?? '-';
        });
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        setState(() {
          deviceName = iosInfo.name ?? '-';
          osVersion = 'iOS ${iosInfo.systemVersion ?? '-'}';
          model = iosInfo.model ?? '-';
          brand = 'Apple';
        });
      } else {
        setState(() {
          deviceName = 'Platform tidak didukung';
          osVersion = '-';
          model = '-';
          brand = '-';
        });
      }
    } catch (e) {
      setState(() {
        deviceName = 'Error mendapatkan info perangkat';
        osVersion = '-';
        model = '-';
        brand = '-';
      });
    }
  }

  Future<void> getConnectionStatus() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        if (connectivityResult == ConnectivityResult.mobile) {
          connectionStatus = 'Mobile';
        } else if (connectivityResult == ConnectivityResult.wifi) {
          connectionStatus = 'Wi-Fi';
        } else if (connectivityResult == ConnectivityResult.ethernet) {
          connectionStatus = 'Ethernet';
        } else if (connectivityResult == ConnectivityResult.bluetooth) {
          connectionStatus = 'Bluetooth';
        } else {
          connectionStatus = 'Tidak ada koneksi';
        }
      });
    } catch (e) {
      setState(() {
        connectionStatus = 'Gagal mendapatkan status koneksi';
      });
    }
  }

  void startSensor() {
    if (!isSensorActive) {
      _accelerometerSubscription = accelerometerEvents.listen((event) {

        setState(() {
          sensorStatus = 'Aktif';
          movementStatus = (event.x.abs() + event.y.abs() + event.z.abs()) > 1.5
              ? 'Bergerak'
              : 'Tidak bergerak';
        });
      });
      isSensorActive = true;
    }
  }

  Widget infoCard(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget labelText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF5FF),
      appBar: AppBar(
        title: const Text('Info Perangkat & Sensor'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoCard('Informasi Perangkat', [
                labelText('Nama Perangkat', deviceName),
                labelText('Versi OS', osVersion),
                labelText('Model', model),
                labelText('Brand', brand),
              ]),

              infoCard('Status Jaringan', [
                Row(
                  children: [
                    Icon(
                      connectionStatus == 'Wi-Fi'
                          ? Icons.wifi
                          : connectionStatus == 'Mobile'
                              ? Icons.signal_cellular_alt
                              : Icons.signal_wifi_off,
                      color: connectionStatus == 'Tidak ada koneksi' ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(connectionStatus),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF1E4FF)),
                  onPressed: getConnectionStatus,
                  child: const Text('Refresh Status', style: TextStyle(color: Colors.purple)),
                ),
              ]),

              infoCard('Sensor Perangkat', [
                labelText('Status', sensorStatus),
                labelText('Gerakan', movementStatus),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF1E4FF)),
                  onPressed: startSensor,
                  child: const Text('Start Sensor', style: TextStyle(color: Colors.purple)),
                ),
              ]),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SensorExampleScreen()),
                    );
                  },
                  child: const Text('Buka Sensor Screen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
