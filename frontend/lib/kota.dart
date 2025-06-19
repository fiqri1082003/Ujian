import 'package:flutter/material.dart';

class KotaDropdown extends StatelessWidget {
  final String selectedKota;
  final List<String> kotaList;
  final ValueChanged<String?> onChanged;

  const KotaDropdown({super.key, 
    required this.selectedKota,
    required this.kotaList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedKota,
      decoration: InputDecoration(
        labelText: 'Filter by Kota',
        border: OutlineInputBorder(),
      ),
      items: kotaList
          .map((kota) => DropdownMenuItem(
                value: kota,
                child: Text(kota),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
