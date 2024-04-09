import 'package:flutter/material.dart';
import 'package:quiz_app_project/models/Questions.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height / 4,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.8),
      ),
      child: Center(
        child: Text(
          question.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
