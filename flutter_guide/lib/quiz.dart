import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final String question;
  final List answers;
  final Function answerCallback;

  Quiz({
    required this.question,
    required this.answers,
    required this.answerCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(question),
        ...answers.map((answer) {
          return Answer(
            answerText: answer["text"].toString(),
            answerCallback: () => answerCallback(answer["score"]),
          );
        }).toList(),
      ],
    );
  }
}
