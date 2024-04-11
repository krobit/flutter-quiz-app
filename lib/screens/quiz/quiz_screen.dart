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
      title: 'What is the capital of France?',
      options: {
        'Paris': true,
        'Berlin': false,
        'Rome': false,
        'Madrid': false,
      },
    ),
    Question(
      id: '2',
      title: 'Who is the author of "The Great Gatsby"?',
      options: {
        'F. Scott Fitzgerald': true,
        'Ernest Hemingway': false,
        'John Steinbeck': false,
        'Mark Twain': false,
      },
    ),
    Question(
      id: '3',
      title: 'What is the chemical symbol for water?',
      options: {
        'H2O': true,
        'CO2': false,
        'O2': false,
        'NaCl': false,
      },
    ),
    Question(
      id: '4',
      title: 'What is the tallest mountain in the world?',
      options: {
        'Mount Everest': true,
        'K2': false,
        'Kangchenjunga': false,
        'Lhotse': false,
      },
    ),
    Question(
      id: '5',
      title: 'Who painted the Mona Lisa?',
      options: {
        'Leonardo da Vinci': true,
        'Pablo Picasso': false,
        'Vincent van Gogh': false,
        'Michelangelo': false,
      },
    ),
    Question(
      id: '6',
      title: 'What is the largest ocean on Earth?',
      options: {
        'Pacific Ocean': true,
        'Atlantic Ocean': false,
        'Indian Ocean': false,
        'Southern Ocean': false,
      },
    ),
    Question(
      id: '7',
      title: 'What year did World War II end?',
      options: {
        '1945': true,
        '1939': false,
        '1941': false,
        '1943': false,
      },
    ),
    Question(
      id: '8',
      title: 'Which planet is known as the Red Planet?',
      options: {
        'Mars': true,
        'Jupiter': false,
        'Saturn': false,
        'Venus': false,
      },
    ),
    Question(
      id: '9',
      title: 'Who is credited with discovering gravity?',
      options: {
        'Isaac Newton': true,
        'Albert Einstein': false,
        'Galileo Galilei': false,
        'Nikola Tesla': false,
      },
    ),
    Question(
      id: '10',
      title: 'What is the primary ingredient in guacamole?',
      options: {
        'Avocado': true,
        'Tomato': false,
        'Onion': false,
        'Lemon': false,
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
    _questions.shuffle();
    _questions.forEach((question) {
      question.options =
          Map.fromEntries(question.options.entries.toList()..shuffle());
    });
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
      Future.delayed(const Duration(seconds: 1), () {
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
            Text('${_currentQuestion + 1} of ${_questions.length}'),
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
