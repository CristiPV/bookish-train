import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      "questionText": "Hello, what is age ?",
      "answers": [
        {"text": "< 18", "score": 1},
        {"text": 18, "score": 10},
        {"text": "> 18", "score": 15},
        {"text": "I have no idea", "score": 100},
      ],
    },
    {
      "questionText": "Name, what is ?",
      "answers": [
        {"text": "I was not given any name", "score": 100},
        {"text": "Garry", "score": 10},
        {"text": "Barry", "score": 20},
      ],
    },
  ];

  var _questionIndex = 0;
  var _score = 0;

  void _answerQuestion(int answerScore) {
    _score += answerScore;
    setState(() => _questionIndex++);
    print("Answer chosen!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello, I am title"),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                question: _questions[_questionIndex]["questionText"] as String,
                answers: _questions[_questionIndex]["answers"] as List<Map<String, Object>>,
                answerCallback: _answerQuestion)
            : Result(
                score: _score,
                restartCallback: () {
                  _score = 0;
                  setState(() => _questionIndex = 0);
                },
              ),
      ),
    );
  }
}
