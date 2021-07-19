import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final String question;
  final List answers;
  final VoidCallback answerCallback;

  Quiz(this.question, this.answers, this.answerCallback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(question),
        ...answers.map((answer) {
          return Answer(answer.toString(), answerCallback);
        }).toList(),
      ],
    );
  }
}
