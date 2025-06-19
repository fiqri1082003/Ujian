import 'package:flutter/material.dart';
import 'add_wisata.dart'; 

class Wisata {
  final String nama;
  final String kota;
  final String jenis; 
  bool isFavorite;

  Wisata({
    required this.nama,
    required this.kota,
    required this.jenis,
    this.isFavorite = false,
  });
}

class DaftarWisataScreen extends StatefulWidget {
  const DaftarWisataScreen({Key? key}) : super(key: key);

  @override
  State<DaftarWisataScreen> createState() => _DaftarWisataScreenState();
}

class _DaftarWisataScreenState extends State<DaftarWisataScreen> {
  final List<Wisata> _allWisata = [
    Wisata(nama: 'Raja Ampat', kota: 'Papua Barat', jenis: 'Alam'),
    Wisata(nama: 'Candi Borobudur', kota: 'Jawa Tengah', jenis: 'Monumen'),
    Wisata(nama: 'Gunung Bromo', kota: 'Jawa Timur', jenis: 'Alam'),
    Wisata(nama: 'Monas', kota: 'Jakarta', jenis: 'Monumen'),
    Wisata(nama: 'Danau Toba', kota: 'Sumatera Utara', jenis: 'Alam'),
    Wisata(nama: 'Taman Mini Indonesia Indah', kota: 'Jakarta', jenis: 'Monumen'),
  ];

  

  List<Wisata> _filteredWisata = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredWisata = List.from(_allWisata);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredWisata = _allWisata.where((w) {
        return w.nama.toLowerCase().contains(query) ||
            w.kota.toLowerCase().contains(query) ||
            w.jenis.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      
      final originalWisataIndex = _allWisata.indexOf(_filteredWisata[index]);
      if (originalWisataIndex != -1) {
        _allWisata[originalWisataIndex].isFavorite = !_allWisata[originalWisataIndex].isFavorite;
      }
      _filteredWisata[index].isFavorite = !_filteredWisata[index].isFavorite; // Update status di filtered list
    });
  }

  Future<void> _navigateToAddWisataScreen() async {
    final newWisata = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddWisataScreen()),
    );

    if (newWisata != null && newWisata is Wisata) {
      setState(() {
        _allWisata.add(newWisata);
        _onSearchChanged(); 
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari tempat wisata...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredWisata.length,
              itemBuilder: (context, index) {
                final wisata = _filteredWisata[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(wisata.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${wisata.kota} • ${wisata.jenis}'),
                    trailing: IconButton(
                      icon: Icon(
                        wisata.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: wisata.isFavorite ? Colors.red : null,
                      ),
                      onPressed: () => _toggleFavorite(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton( 
        onPressed: _navigateToAddWisataScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
