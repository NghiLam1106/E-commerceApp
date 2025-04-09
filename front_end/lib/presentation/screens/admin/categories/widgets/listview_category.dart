import 'package:flutter/material.dart';

class ListviewCategory extends StatelessWidget {
  const ListviewCategory({
    super.key,
    required this.name,
    required this.imageURL,
    required this.onEdit,
    required this.onDelete, required this.id,
  });

  final String id, name,imageURL;
  final VoidCallback onEdit, onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Image.network(imageURL),
          title: Text('Loại sản phẩm: $name', style: Theme.of(context).textTheme.titleMedium!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  onDelete;
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}