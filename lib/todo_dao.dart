// lib/todo_dao.dart
import 'package:floor/floor.dart';
import 'todo_item.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM TodoItem')
  Future<List<TodoItem>> findAllItems();

  @insert
  Future<int> insertItem(TodoItem item);

  @delete
  Future<void> deleteItem(TodoItem item);
}