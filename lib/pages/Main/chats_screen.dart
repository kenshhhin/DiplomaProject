import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: const Center(
        child: Text(
          'Список чатов с тренерами и клиентами',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
