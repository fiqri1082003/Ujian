import 'package:flutter/material.dart';

class LokasiScreen extends StatefulWidget {
  const LokasiScreen({Key? key}) : super(key: key);

  @override
  State<LokasiScreen> createState() => _LokasiScreenState();
}

class _LokasiScreenState extends State<LokasiScreen> {
  final List<String> _kotaList = ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Bali'];
  String? _selectedKota;

  
  final Map<String, List<String>> _rekomendasiWisata = {
    'Jakarta': ['Monas', 'Kota Tua', 'Ancol'],
    'Bandung': ['Tangkuban Perahu', 'Farmhouse', 'Dago'],
    'Surabaya': ['House of Sampoerna', 'Taman Bungkul', 'Kenjeran'],
    'Yogyakarta': ['Candi Prambanan', 'Pantai Parangtritis', 'Malioboro'],
    'Bali': ['Pantai Kuta', 'Ubud', 'Tanah Lot'],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: const [
              Icon(Icons.my_location, color: Colors.blue),
              SizedBox(width: 8),
              Text('Lokasi saat ini: Jakarta', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),

          
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Pilih Kota',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            value: _selectedKota,
            items: _kotaList.map((kota) {
              return DropdownMenuItem(
                value: kota,
                child: Text(kota),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedKota = value;
              });
            },
          ),
          const SizedBox(height: 24),

          
          Text(
            'Rekomendasi Wisata di ${_selectedKota ?? '-'}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _selectedKota == null
                ? const Center(child: Text('Pilih kota untuk melihat rekomendasi wisata'))
                : ListView(
                    children: _rekomendasiWisata[_selectedKota!]!
                        .map((wisata) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: const Icon(Icons.place, color: Colors.deepPurple),
                                title: Text(wisata),
                              ),
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
