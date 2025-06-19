import 'package:flutter/material.dart';

class WisataCard extends StatelessWidget {
  final String name;
  final String city;
  final String category;

  const WisataCard({
    Key? key,
    required this.name,
    required this.city,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text("$city - $category"),
      trailing: const Icon(Icons.favorite, color: Colors.red),
    );
  }
}
