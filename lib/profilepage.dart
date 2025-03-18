import 'package:firstapp/drawer.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      drawer: CustomDrawer(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 75,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Apiwat Naemsai',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            'Developer',
            style: TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 49, 113, 232)),
          ),
          Text(
            'tel: 081-234-5678',
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
        ],
      )),
    );
  }
}
