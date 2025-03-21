import 'package:flutter/material.dart';
import 'drawer.dart';

class TodolistPage extends StatefulWidget {
  const TodolistPage({super.key});

  @override
  State<TodolistPage> createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _todoItems = [];

  void _addTodoItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todoItems.add({'title': _controller.text, 'completed': false});
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void _toggleTodoStatus(int index, bool? value) {
    setState(() {
      _todoItems[index]['completed'] = value ?? false;
    });
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('เพิ่มรายการใหม่'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'กรอกรายการ...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: _addTodoItem,
            child: const Text('เพิ่ม'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todolist')),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_todoItems[index]['title']),
            trailing: Checkbox(
              value: _todoItems[index]['completed'],
              onChanged: (value) => _toggleTodoStatus(index, value),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
