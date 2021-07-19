import 'package:flutter/material.dart';

import './quiz.dart';
import './restart.dart';

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
  final questions = const [
    {
      "questionText": "Hello, what is age ?",
      "answers": ["< 18", 18, "> 18", "I have no idea"],
    },
    {
      "questionText": "Name, what is ?",
      "answers": ["I was not given any name", "Garry", "Barry", "What ?"],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion() {
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
        body: _questionIndex < questions.length
            ? Quiz(questions[_questionIndex]["questionText"] as String,
                questions[_questionIndex]["answers"] as List, _answerQuestion)
            : Restart(() => setState(() => _questionIndex = 0)),
      ),
    );
  }
}
