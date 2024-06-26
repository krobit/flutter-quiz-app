import 'package:flutter/material.dart';
import 'package:quiz_app_project/screens/quiz/quiz_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Quiz",
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}
