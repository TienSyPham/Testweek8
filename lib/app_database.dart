import 'package:floor/floor.dart';
import 'dart:async';
import 'todoitem.dart';
import 'todoitem_DAO.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [ToDoItem])
abstract class AppDatabase extends FloorDatabase
{
  ToDoItemDao get todoDao;
}
