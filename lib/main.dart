import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  //ประกาศตัวแปรและฟังก์ชั่นตรงนี้
  String username = "Apiwat naemsai";
  String profileName = " ";
  String position = " ";
  String tel = " ";

  String showPosition() {
    return "Software Developer";
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      profileName = prefs.getString("profileName") ?? "ยังไม่ใส่ชื่อ";
      position = prefs.getString("position") ?? "ยังไม่ใส่ตำแหน่ง";
      tel = prefs.getString("phone") ?? "ยังไม่ใส่เบอร์โทร";
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void initstate() {
    super.initState();
    _loadData();
    // ignore: avoid_print
    print("โหลดหน้าเสร็จแล้ว");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: const Color.fromARGB(255, 84, 216, 234),
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
            username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            showPosition(),
            style: TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 49, 113, 232)),
          ),
          Text(
            tel,
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
          // OverflowBar(
          //   alignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     TextButton(child: const Text('Edit'), onPressed: () {}),
          //   ],
          // ), //ไม่มีปุ่มนูน
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KilometersToMilesScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                backgroundColor: const Color.fromARGB(255, 72, 180, 48),
              ),
              child: const Text('Start',
                  style: TextStyle(fontSize: 16, color: Colors.white))),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                backgroundColor: const Color.fromARGB(255, 74, 53, 230),
              ),
              child: const Text('Edit',
                  style: TextStyle(fontSize: 16, color: Colors.white))),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: _loadData,
              child: const Text("โหลดข็อมูล")) //มีปุ่มนูน สวยกว่า
        ],
      )),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController profilenameController = TextEditingController();
  final TextEditingController positionnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('profileName', profilenameController.text);
    prefs.setString('position', positionnameController.text);
    prefs.setString('phone', phoneController.text);

    // ignore: avoid_print
    print("บันทึกเรียบร้อย");
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("เซฟเรียบร้อย")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: const Color.fromARGB(255, 84, 216, 234),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: profilenameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  hintText: 'ชื่อ-สกุล',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: positionnameController,
                decoration: InputDecoration(
                  labelText: 'Enter your position',
                  hintText: 'ตำแหน่ง',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Enter your phone number',
                  hintText: 'เบอร์โทรศัพท์',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  _saveData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserProfilePage()), // Corrected this part
                  );
                },
                child: Text("บันทึกข้อมูล"),
              ), //มีปุ่มนูน สวยกว่า
            ],
          ),
        ),
      ),
    );
  }
}

class KilometersToMilesScreen extends StatefulWidget {
  const KilometersToMilesScreen({super.key});

  @override
  State<KilometersToMilesScreen> createState() =>
      _KilometersToMilesScreenState();
}

class _KilometersToMilesScreenState extends State<KilometersToMilesScreen> {
  final TextEditingController kmController = TextEditingController();

  void _convertAndSave() async {
    final prefs = await SharedPreferences.getInstance();
    double km = double.tryParse(kmController.text) ?? 0.0;
    double miles = km * 0.621371;
    await prefs.setDouble('kilometers', km);
    await prefs.setDouble('miles', miles);

    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const ConversionResultScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kilometers to Miles')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: kmController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Enter kilometers'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convertAndSave,
                child: const Text('Convert & Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConversionResultScreen extends StatefulWidget {
  const ConversionResultScreen({super.key});

  @override
  State<ConversionResultScreen> createState() => _ConversionResultScreenState();
}

class _ConversionResultScreenState extends State<ConversionResultScreen> {
  double kilometers = 0.0;
  double miles = 0.0;

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      kilometers = prefs.getDouble('kilometers') ?? 0.0;
      miles = prefs.getDouble('miles') ?? 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversion Result')),
      body: Center(
        child: Text(
          '$kilometers km is equal to ${miles.toStringAsFixed(2)} miles.',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
