import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ваш прогресс",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildProgressTile("Вес", "70 кг → 68 кг", Icons.monitor_weight, Colors.orange),
            _buildProgressTile("Сила", "Жим 50 кг → 60 кг", Icons.fitness_center, Colors.purple),
            _buildProgressTile("Выносливость", "10 км → 12 км", Icons.directions_run, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTile(String title, String progress, IconData icon, Color color) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        subtitle: Text(progress, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
