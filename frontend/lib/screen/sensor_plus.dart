import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorExampleScreen extends StatefulWidget {
  const SensorExampleScreen({super.key});

  @override
  State<SensorExampleScreen> createState() => _SensorExampleScreenState();
}

class _SensorExampleScreenState extends State<SensorExampleScreen> {
  double x = 0, y = 0, z = 0;
  bool isSensorActive = false;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  void startSensor() {
    if (!isSensorActive) {
      _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {
          x = event.x;
          y = event.y;
          z = event.z;
        });
      });
      setState(() {
        isSensorActive = true;
      });
    }
  }

  void stopSensor() {
    if (isSensorActive) {
      _accelerometerSubscription?.cancel();
      _accelerometerSubscription = null;
      setState(() {
        isSensorActive = false;
        x = 0;
        y = 0;
        z = 0;
      });
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Accelerometer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nilai Accelerometer:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('X: \${x.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            Text('Y: \${y.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            Text('Z: \${z.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: isSensorActive ? stopSensor : startSensor,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSensorActive ? Colors.red : Colors.green,
              ),
              child: Text(isSensorActive ? 'Stop Sensor' : 'Start Sensor'),
            ),
          ],
        ),
      ),
    );
  }
}
