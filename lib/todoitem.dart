import 'package:floor/floor.dart';

@Entity(tableName: 'ToDoItem')
class ToDoItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String task;

  ToDoItem({this.id, required this.task});
}
