// lib/list_page.dart
import 'package:flutter/material.dart';
import 'todo_item.dart';

class ListPage extends StatelessWidget {
  final List<TodoItem> items;
  final TodoItem? selected;
  final ValueChanged<TodoItem> onTap;
  final Future<void> Function(String, int) onAdd;

  const ListPage({
    super.key,
    required this.items,
    this.selected,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final itemCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: itemCtrl,
                  decoration: InputDecoration(hintText: 'Item name'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: qtyCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Quantity'),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final name = itemCtrl.text.trim();
                  final qty = int.tryParse(qtyCtrl.text.trim()) ?? 0;
                  if (name.isNotEmpty) onAdd(name, qty);
                },
                child: Text('Add'),
              ),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: items.isEmpty
                ? Center(child: Text('No items'))
                : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (_, i) {
                final it = items[i];
                return ListTile(
                  title: Text(it.name),
                  subtitle: Text('Quantity: ${it.qty}'),
                  selected: selected?.id == it.id,
                  onTap: () => onTap(it),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

