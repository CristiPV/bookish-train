import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final Color boxColor;

  TextBox(this.text, {this.boxColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      padding: EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: boxColor,
          width: 3,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
