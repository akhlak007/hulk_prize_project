import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GameController {
  final ValueNotifier<double> ballPosition = ValueNotifier<double>(0.0);
  final ValueNotifier<int> timer = ValueNotifier<int>(0);
  final ValueNotifier<int> totalScore = ValueNotifier<int>(0);
  
  StreamSubscription? _gyroscopeSubscription;
  Timer? _gameTimer;
  bool _isStable = false;
  int _stableStartTime = 0;
  
  static const double stabilityThreshold = 0.1;
  static const int targetDuration = 5;

  GameController() {
    _initializeGyroscope();
  }

  void _initializeGyroscope() {
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      // Use x-axis rotation for horizontal movement
      double newPosition = ballPosition.value + (event.x * 0.1);
      // Limit the ball's movement range
      newPosition = newPosition.clamp(-1.0, 1.0);
      ballPosition.value = newPosition;
      
      _checkStability(newPosition);
    });
  }

  void _checkStability(double position) {
    if (position.abs() < stabilityThreshold) {
      if (!_isStable) {
        _isStable = true;
        _stableStartTime = DateTime.now().millisecondsSinceEpoch;
        _startTimer();
      }
    } else {
      if (_isStable) {
        _isStable = false;
        _resetTimer();
      }
    }
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isStable) {
        this.timer.value = timer.tick;
        if (timer.tick >= targetDuration) {
          _handleSuccess();
        }
      }
    });
  }

  void _resetTimer() {
    _gameTimer?.cancel();
    timer.value = 0;
  }

  void _handleSuccess() {
    _gameTimer?.cancel();
    int duration = DateTime.now().millisecondsSinceEpoch - _stableStartTime;
    totalScore.value += (duration ~/ 1000);
    timer.value = 0;
    _isStable = false;
  }

  void dispose() {
    _gyroscopeSubscription?.cancel();
    _gameTimer?.cancel();
  }
}