import 'package:firstapp/database_helper.dart';
import 'package:firstapp/drawer.dart';
import 'package:flutter/material.dart';
import 'todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late Future<List<Todo>> _todoList;
  @override
  void initState() {
    super.initState();
    _todoList = _fetchTodos(); // ดึงข้อมูล Todo เมื่อเริ่มต้นหน้า
  }

  Future<List<Todo>> _fetchTodos() async {
    return await DatabaseHelper().getTodos();
  }

  void _toggleTodoCompletion(Todo todo) async {
    todo.isCompleted = !todo.isCompleted; // สลับสถานะการทำเสร็จ
    await DatabaseHelper().updateTodo(todo); // อัปเดตสถานะในฐานข้อมูล
    setState(() {
      _todoList = _fetchTodos(); // รีเฟรชรายการ Todo หลังจากอัปเดต
    });
  }

  void _addTodo() {
    TextEditingController _todoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        String tast = '';
        return AlertDialog(
            title: const Text('Add Todo'),
            content: TextField(
              onChanged: (value) {
                tast = value; // onchanged ใช้ได้แต่กินประสิทธิภาพเครื่่อง
              },
              controller: _todoController,
              decoration: const InputDecoration(hintText: 'Enter Todo'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (tast.isNotEmpty) {
                      final todo = Todo(
                        task: tast,
                        isCompleted: false,
                      );
                      DatabaseHelper().insertTodo(todo);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('บันทึก'))
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder<List<Todo>>(
          future: _todoList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // แสดง loading ถ้ายังโหลดไม่เสร็จ
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'Error: ${snapshot.error}')); // แสดงข้อความถ้ามีข้อผิดพลาด
            }

            final todos = snapshot.data ?? [];

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.task), // แสดงชื่อ Todo
                  trailing: Checkbox(
                    value: todo.isCompleted, // แสดงสถานะการทำเสร็จ
                    onChanged: (value) {
                      _toggleTodoCompletion(todo); // เมื่อคลิกเพื่ออัปเดตสถานะ
                    },
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
