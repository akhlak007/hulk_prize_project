import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';

class BalanceBeam extends StatelessWidget {
  final GameController controller;

  const BalanceBeam({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}