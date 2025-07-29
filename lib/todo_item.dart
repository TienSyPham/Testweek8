// lib/todo_item.dart
import 'package:floor/floor.dart';

@entity
class TodoItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final int qty;

  TodoItem({this.id, required this.name, required this.qty});
}
