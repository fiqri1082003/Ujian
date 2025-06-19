import 'package:flutter/material.dart';

class WisataCard extends StatelessWidget {
  final String name;
  final String city;
  final String category;

  const WisataCard(this.name, this.city, this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('$city - $category'),
      trailing: const Icon(Icons.favorite, color: Colors.red),
    );
  }
}

class AddWisataScreen extends StatelessWidget {
  const AddWisataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Wisata')),
      body: const Center(child: Text('Form tambah wisata di sini')),
    );
  }
}
