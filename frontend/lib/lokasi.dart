import 'package:flutter/material.dart';

class LokasiSaatIniCard extends StatelessWidget {
  final String lokasiInfo;
  final VoidCallback onDapatkanLokasi;

  const LokasiSaatIniCard({super.key, 
    required this.lokasiInfo,
    required this.onDapatkanLokasi,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);

    return Card(
      color: Colors.deepPurple.shade50,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onDapatkanLokasi,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lokasi Saat Ini', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(lokasiInfo),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onDapatkanLokasi,
                    icon: Icon(Icons.location_on, color: Colors.deepPurple),
                    label: Text('Dapatkan Lokasi', style: TextStyle(color: Colors.deepPurple)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.deepPurple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
