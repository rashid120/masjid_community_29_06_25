import 'package:flutter/material.dart';

class CollectionCardWidget extends StatelessWidget {
  final String collectionName;
  final VoidCallback onTap;

  const CollectionCardWidget({
    super.key,
    required this.collectionName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          collectionName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: const Icon(Icons.folder),
        onTap: onTap,
      ),
    );
  }
}