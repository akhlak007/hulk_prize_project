import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';

class Ball extends StatelessWidget {
  final GameController controller;

  const Ball({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: controller.ballPosition,
      builder: (context, position, _) {
        return Align(
          alignment: Alignment(position, 0),
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}