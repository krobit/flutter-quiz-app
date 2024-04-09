import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required int timeLeft,
  }) : _timeLeft = timeLeft;

  final int _timeLeft;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: _timeLeft / 20,
            strokeWidth: 10,
            backgroundColor: const Color(0xFFABD1C6),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF004643)),
          ),
          Center(
            child: Text(
              '$_timeLeft',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
