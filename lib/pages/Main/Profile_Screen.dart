import 'package:flutter/material.dart';
import 'EditProfile_Screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Даулет";
  String surname = "Карибеков";
  int age = 19;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Мой профиль")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 10),
            Text(
              "$name $surname",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("$age лет", style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      name: name,
                      surname: surname,
                      age: age,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    name = result['name'];
                    surname = result['surname'];
                    age = result['age'];
                  });
                }
              },
              icon: const Icon(Icons.edit),
              label: const Text("Редактировать профиль"),
            ),
          ],
        ),
      ),
    );
  }
}
