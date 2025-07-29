// lib/master_detail_page.dart
import 'package:flutter/material.dart';
import 'database.dart';
import 'todo_dao.dart';
import 'todo_item.dart';
import 'list_page.dart';
import 'details_page.dart';

class MasterDetailPage extends StatefulWidget {
  const MasterDetailPage({super.key});
  @override
  State<MasterDetailPage> createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  late final AppDatabase _db;
  late final TodoDao _dao;
  List<TodoItem> _items = [];
  TodoItem? _selected;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    _db = await $FloorAppDatabase.databaseBuilder('app.db').build();
    _dao = _db.todoDao;
    _items = await _dao.findAllItems();
    setState(() {});
  }

  Future<void> _add(String name, int qty) async {
    final id = await _dao.insertItem(TodoItem(name: name, qty: qty));
    final newItem = TodoItem(id: id, name: name, qty: qty);
    setState(() => _items.add(newItem));
  }

  Future<void> _delete() async {
    if (_selected != null) {
      await _dao.deleteItem(_selected!);
      setState(() {
        _items.removeWhere((i) => i.id == _selected!.id);
        _selected = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        leading: (!isTablet && _selected != null)
            ? BackButton(onPressed: () => setState(() => _selected = null))
            : null,
        title: const Text('Flutter Week 9 – Responsive Lab'),
      ),
      body: isTablet
          ? Row(
        children: [
          Expanded(
            child: ListPage(
              items: _items,
              selected: _selected,
              onTap: (it) => setState(() => _selected = it),
              onAdd: _add,
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: DetailsPage(
              item: _selected,
              onDelete: _delete,
              onClose: () => setState(() => _selected = null),
            ),
          ),
        ],
      )
          : (_selected == null
          ? ListPage(
        items: _items,
        selected: _selected,
        onTap: (it) => setState(() => _selected = it),
        onAdd: _add,
      )
          : DetailsPage(
        item: _selected,
        onDelete: _delete,
        onClose: () => setState(() => _selected = null),
      )),
    );
  }
}