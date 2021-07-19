import 'package:flutter/material.dart';

import './restart.dart';

class Result extends StatelessWidget {
  final VoidCallback restartCallback;
  final int score;

  Result({required this.score, required this.restartCallback});

  String get resultPhrase {
    var resultText = "You did it !\nYour score was: ${score}";
    if (score > 100) {
      resultText = "Amazing !\nYour score was: ${score}";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 15),
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(
              color: Colors.green[300],
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Restart(restartCallback),
        ],
      ),
    );
  }
}
