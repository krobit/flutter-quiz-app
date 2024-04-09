import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app_project/models/Questions.dart';
import 'package:quiz_app_project/screens/quiz/components/option_card.dart';
import 'package:quiz_app_project/screens/quiz/components/result_box.dart';

import 'components/progress_bar.dart';
import 'components/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _timeLeft = 20;
  Timer? _timer;

  int _currentQuestion = 0;
  int _score = 0;

  bool _isCorrect = false;
  int _selectedAnswerIndex = -1;
  String? selectedAnswer;

  final List<Question> _questions = [
    Question(
      id: '1',
      title: 'What is the capital of India?',
      options: {
        'New Delhi': true,
        'Bangalore': false,
        'Mumbai': false,
        'Chennai': false,
      },
    ),
    Question(
      id: '2',
      title: 'What is the capital of USA?',
      options: {
        'Washington D.C.': true,
        'New York': false,
        'Los Angeles': false,
        'Chicago': false,
      },
    ),
    Question(
      id: '3',
      title: 'What is the capital of China?',
      options: {
        'Beijing': true,
        'Shanghai': false,
        'Shenzhen': false,
        'Guangzhou': false,
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeLeft == 0) {
          timer.cancel();
          nextQuestion();
        } else {
          setState(() {
            _timeLeft--;
          });
        }
      },
    );
  }

  void checkAnswer(String selectedAnswer, int index) {
    setState(() {
      _isCorrect = _questions[_currentQuestion].options[selectedAnswer]!;
      _selectedAnswerIndex = index;
      if (_isCorrect) {
        _score++;
      }
    });
    nextQuestion();
  }

  void nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      _questions[_currentQuestion].options.forEach((key, value) {
        if (value == true) {
          selectedAnswer = key;
        }
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _currentQuestion++;
          _selectedAnswerIndex = -1;
          _timeLeft = 20;
        });
        startTimer();
      });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: _score,
                questionLength: _questions.length,
                onPressed: startOver,
              ));
    }
  }

  void startOver() {
    setState(() {
      _score = 0;
      _currentQuestion = 0;
      _selectedAnswerIndex = -1;
      _timeLeft = 20;
      _isCorrect = false;
      selectedAnswer = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Question question = _questions[_currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          Text("Score: $_score"),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            Text('${_currentQuestion} of ${_questions.length}'),
            const SizedBox(height: 20.0),
            ProgressBar(timeLeft: _timeLeft),
            const SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    QuestionCard(question: question),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: question.options.length,
                      itemBuilder: (context, index) {
                        String option = question.options.keys.toList()[index];
                        bool isSelected = index == _selectedAnswerIndex;
                        bool isCorrect = _isCorrect && isSelected;
                        return OptionCard(
                          index: index + 1,
                          option: option,
                          onTap: () {
                            if (_selectedAnswerIndex == -1) {
                              checkAnswer(option, index);
                            }
                          },
                          isSelected: isSelected,
                          isCorrect: isCorrect,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
