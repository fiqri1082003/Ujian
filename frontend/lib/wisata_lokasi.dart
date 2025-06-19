import 'package:flutter/material.dart';
import 'wisata.dart';

class WisataLokasiCard extends StatelessWidget {
  final Wisata wisata;
  final VoidCallback onFavoriteToggle;

  const WisataLokasiCard({super.key, 
    required this.wisata,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(wisata.nama),
        subtitle: Text('${wisata.kota} - ${wisata.kategori}'),
        trailing: IconButton(
          icon: Icon(
            wisata.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: wisata.isFavorite ? Colors.red : null,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
