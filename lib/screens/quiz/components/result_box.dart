import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  });

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Padding(
      padding: EdgeInsets.all(70.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? Colors.red
                      : Colors.green,
              child: Text('$result/$questionLength',
                  style: const TextStyle(
                    fontSize: 30,
                  )),
            ),
            const SizedBox(height: 20.0),
            Text(
              result == questionLength / 2
                  ? 'You are correct!'
                  : result < questionLength / 2
                      ? 'You are too low!'
                      : 'Great!',
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: onPressed,
              child: const Text(
                'Start over',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
    ));
  }
}
