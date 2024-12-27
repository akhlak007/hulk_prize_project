import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';

class TimerDisplay extends StatelessWidget {
  final GameController controller;

  const TimerDisplay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ValueListenableBuilder<int>(
        valueListenable: controller.timer,
        builder: (context, seconds, _) {
          return Text(
            'Time: $seconds / 5',
            style: Theme.of(context).textTheme.headlineSmall,
          );
        },
      ),
    );
  }
}