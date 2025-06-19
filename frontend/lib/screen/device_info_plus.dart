import 'package:flutter/material.dart';
import 'device_info_plus.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DeviceInfoExampleScreen extends StatefulWidget {
  const DeviceInfoExampleScreen({super.key});

  @override
  State<DeviceInfoExampleScreen> createState() => _DeviceInfoExampleScreenState();
}

class _DeviceInfoExampleScreenState extends State<DeviceInfoExampleScreen> {
  String deviceName = '-';
  String osVersion = '-';
  String model = '-';
  String brand = '-';

  @override
  void initState() {
    super.initState();
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoExampleScreen();

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = androidInfo.device ?? '-';
          osVersion = 'Android ${androidInfo.version.release ?? '-'}';
          model = androidInfo.model ?? '-';
          brand = androidInfo.brand ?? '-';
        });
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
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
        deviceName = 'Gagal mengambil info';
        osVersion = '-';
        model = '-';
        brand = '-';
      });
    }
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoRow('Nama Perangkat', deviceName),
            buildInfoRow('Versi OS', osVersion),
            buildInfoRow('Model', model),
            buildInfoRow('Brand', brand),
          ],
        ),
      ),
    );
  }
}
