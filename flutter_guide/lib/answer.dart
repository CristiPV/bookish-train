import 'dart:ffi';

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback answerCallback;

  Answer({
    required this.answerText,
    required this.answerCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange[400]),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onPressed: answerCallback,
        child: Text(answerText),
      ),
    );
  }
}
