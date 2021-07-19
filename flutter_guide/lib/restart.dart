import 'package:flutter/material.dart';

import './question.dart';

class Restart extends StatelessWidget {
  final VoidCallback restartCallback;

  Restart(this.restartCallback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question("Do you wish to Restart ?"),
        ElevatedButton(onPressed: restartCallback, child: Text("Restart")),
      ],
    );
  }
}
