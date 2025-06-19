import 'package:flutter/material.dart';
import 'package:ujian_bnsp/wisata.dart'; 
import 'screen/daftar_wisata.dart'; 

class FavoritWisataScreen extends StatelessWidget {
  final List<Wisata> favoriteWisata; // Pastikan penamaan konsisten

  const FavoritWisataScreen({Key? key, required this.favoriteWisata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Favorit'),
      ),
      body: favoriteWisata.isEmpty
          ? const Center(child: Text('Tidak ada wisata favorit.'))
          : ListView.builder(
              itemCount: favoriteWisata.length,
              itemBuilder: (context, index) {
                final wisata = favoriteWisata[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      wisata.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${wisata.kota} • ${wisata.jenis}'),
                  ),
                );
              },
            ),
    );
  }
}