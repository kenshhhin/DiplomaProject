import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:diploma/services/step_tracker_service.dart';
import 'package:intl/intl.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stepService = Provider.of<StepTrackerService>(context);
    final stepsHistory = _getStepsForLastWeek(stepService.weeklySteps);

    return Scaffold(
      appBar: AppBar(title: const Text('Прогресс шагов')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "График шагов",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildStepsChart(stepsHistory),
          ],
        ),
      ),
    );
  }

  // Получаем список шагов за последние 7 дней
  List<int> _getStepsForLastWeek(Map<String, int> stepsData) {
    List<int> steps = [];
    DateTime today = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      String dateKey = DateFormat('yyyy-MM-dd').format(today.subtract(Duration(days: i)));
      steps.add(stepsData[dateKey] ?? 0);
    }
    return steps;
  }

  Widget _buildStepsChart(List<int> stepsHistory) {
    const days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt().clamp(0, days.length - 1);
                  return Text(days[index], style: const TextStyle(fontSize: 12));
                },
                interval: 1,
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                stepsHistory.length,
                    (index) => FlSpot(index.toDouble(), stepsHistory[index].toDouble()),
              ),
              isCurved: true,
              barWidth: 4,
              color: Colors.blue,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
