class Wisata {
  final String nama;
  final String kota;
  final String kategori;
  bool isFavorite;

  Wisata({
    required this.nama,
    required this.kota,
    required this.kategori,
    this.isFavorite = false,
  });
}
