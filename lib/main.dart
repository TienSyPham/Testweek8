import 'package:flutter/material.dart';
import 'app_database.dart';
import 'todoitem.dart';
import 'todoitem_DAO.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase
      .databaseBuilder('todo.db')
      .build();
  final dao = database.todoDao;

  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget
{
  final ToDoItemDao dao;

  const MyApp(this.dao, {super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'To-Do List Floor Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(dao),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  final ToDoItemDao dao;

  const MyHomePage(this.dao, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  final TextEditingController _taskController = TextEditingController();
  List<ToDoItem> _items = [];

  @override
  void initState()
  {
    super.initState();
    widget.dao.findAllItems().then((list)
    {
      setState(() => _items = list);
    });
  }

  void _addItem()
  {
    final task = _taskController.text.trim();
    if (task.isEmpty) return;

    final newItem = ToDoItem(task: task);
    widget.dao.insertItem(newItem).then((_)
    {
      setState(() => _items.add(newItem));
      _taskController.clear();
    });
  }

  void _confirmDelete(int index)
  {
    showDialog(
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text('Are you sure you want to delete "${_items[index].task}"?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: ()
              {
                final item = _items[index];
                widget.dao.deleteItem(item).then((_)
                {
                  setState(() => _items.removeAt(index));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(labelText: 'Week 8 To-Do Task'),
                  ),
                ),
                const SizedBox(width: 10),

                ElevatedButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),

              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _items.isEmpty
                ? const Center(
              child: Text(
                'There are no tasks yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return GestureDetector(
                  onLongPress: () => _confirmDelete(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text('${index + 1}.', textAlign: TextAlign.right),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(item.task, textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
