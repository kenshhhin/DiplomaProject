import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:diploma/services/workout_service.dart';
import 'package:diploma/models/workout_session.dart';

class StepTrackerService extends ChangeNotifier {
  int _steps = 0;
  double _distance = 0.0;
  final WorkoutService _workoutService = WorkoutService();
  StreamSubscription<StepCount>? _stepCountStream;

  int get steps => _steps;
  double get distance => _distance;

  StepTrackerService() {
    _initPermissions();
  }

  Future<void> _initPermissions() async {
    await Permission.activityRecognition.request();
    _startTracking();
  }

  void _startTracking() {
    _stepCountStream = Pedometer.stepCountStream.listen((StepCount event) {
      _steps = event.steps;
      notifyListeners();
    });
  }

  Future<void> saveWorkout() async {
    final workout = WorkoutSession(
      steps: _steps,
      distance: _distance,
      calories: (_steps * 0.04).toInt(), // Примерное вычисление калорий
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
