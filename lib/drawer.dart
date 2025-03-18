import 'package:firstapp/profilepage.dart';
import 'package:firstapp/todoList.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // ignore: unnecessary_const
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Apiwat Naemsai ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
          ListTile(
              title: const Text('Profile page'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Profilepage()),
                );
              }),
          ListTile(
              title: const Text('Todo List'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TodoListPage()),
                );
              }),
        ],
      ),
    );
  }
}
