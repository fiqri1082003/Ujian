import 'package:flutter/material.dart';

class KotaManualCard extends StatelessWidget {
  final String selectedKota;
  final List<String> kotaList;
  final ValueChanged<String?> onKotaChanged;
  final TextEditingController kotaController;

  const KotaManualCard({super.key, 
    required this.selectedKota,
    required this.kotaList,
    required this.onKotaChanged,
    required this.kotaController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade50,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih Kota Manual', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedKota,
              decoration: InputDecoration(
                labelText: 'Pilih Kota',
                border: OutlineInputBorder(),
              ),
              items: kotaList
                  .map((kota) => DropdownMenuItem(
                        value: kota,
                        child: Text(kota),
                      ))
                  .toList(),
              onChanged: onKotaChanged,
            ),
            SizedBox(height: 12),
            Text('atau', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            TextField(
              controller: kotaController,
              decoration: InputDecoration(
                hintText: 'Ketik Nama Kota',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
