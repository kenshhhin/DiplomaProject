import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diploma/services/step_tracker_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Сегодняшняя активность",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Consumer<StepTrackerService>(
              builder: (context, stepService, child) {
                return Column(
                  children: [
                    _buildStatCard("Шаги", "${stepService.steps}", Icons.directions_walk, Colors.blue),
                    _buildStatCard("Сожжено калорий", "${(stepService.steps * 0.04).toStringAsFixed(1)} kcal", Icons.local_fire_department, Colors.red),
                    _buildStatCard("Время активности", "${(stepService.steps / 100).toStringAsFixed(1)} мин", Icons.timer, Colors.green),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

