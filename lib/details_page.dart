// lib/details_page.dart
import 'package:flutter/material.dart';
import 'todo_item.dart';

class DetailsPage extends StatelessWidget {
  final TodoItem? item;
  final VoidCallback onDelete;
  final VoidCallback onClose;

  const DetailsPage({
    super.key,
    this.item,
    required this.onDelete,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Center(child: Text('Select an item'));
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${item!.id}'),
          Text('Name: ${item!.name}'),
          Text('Quantity: ${item!.qty}'),
          Spacer(),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: onDelete,
                icon: Icon(Icons.delete),
                label: Text('Delete'),
              ),
              SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: onClose,
                icon: Icon(Icons.close),
                label: Text('Close'),
              ),
            ],
          )
        ],
      ),
    );
  }
}