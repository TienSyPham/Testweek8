import 'package:floor/floor.dart';
import 'package:lab7/todoitem.dart';

@dao
abstract class ToDoItemDao {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllItems();

  @insert
  Future<void> insertItem(ToDoItem item);

  @delete
  Future<void> deleteItem(ToDoItem item);
}
