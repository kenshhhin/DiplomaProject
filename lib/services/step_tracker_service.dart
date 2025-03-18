import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diploma/services/workout_service.dart';
import 'package:diploma/models/workout_session.dart';

class StepTrackerService extends ChangeNotifier {
  int _steps = 0;
  double _distance = 0.0;
  Map<String, int> _weeklySteps = {}; // Хранение шагов за неделю
  final WorkoutService _workoutService = WorkoutService();
  StreamSubscription<StepCount>? _stepCountStream;

  int get steps => _steps;
  double get distance => _distance;
  Map<String, int> get weeklySteps => _weeklySteps; // Геттер для графиков

  StepTrackerService() {
    _initPermissions();
    _loadWeeklySteps();
  }

  Future<void> _initPermissions() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _startTracking();
    } else {
      print("Разрешение на распознавание активности отклонено");
    }
  }

  void _startTracking() {
    _stepCountStream = Pedometer.stepCountStream.listen(
          (StepCount event) {
        _steps = event.steps;
        print("Обновление шагов: $_steps");
        _updateWeeklySteps();
        notifyListeners();
      },
      onError: (error) {
        print("Ошибка в шагомере: $error");
      },
    );
  }

  Future<void> _updateWeeklySteps() async {
    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toIso8601String().split('T')[0]; // YYYY-MM-DD

    _weeklySteps[today] = _steps;

    // Удаляем старые записи (оставляем только последние 7 дней)
    List<String> keys = _weeklySteps.keys.toList();
    if (keys.length > 7) {
      _weeklySteps.remove(keys.first);
    }

    // Сохраняем данные
    await prefs.setString('weekly_steps', jsonEncode(_weeklySteps));
    notifyListeners();
  }

  Future<void> _loadWeeklySteps() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString('weekly_steps');

    if (storedData != null) {
      _weeklySteps = Map<String, int>.from(jsonDecode(storedData));
      notifyListeners();
    }
  }

  Future<void> saveWorkout() async {
    final workout = WorkoutSession(
      steps: _steps,
      distance: _distance,
      calories: (_steps * 0.04).toInt(),
      date: DateTime.now(),
    );
    await _workoutService.saveWorkout(workout);
  }

  @override
  void dispose() {
    _stepCountStream?.cancel();
    super.dispose();
  }
}
