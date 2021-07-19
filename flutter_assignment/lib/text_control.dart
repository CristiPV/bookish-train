import 'package:flutter/material.dart';

import './text_box.dart';

class TextControl extends StatefulWidget {
  final String initialText;
  final String toggleText;

  TextControl({required this.initialText, required this.toggleText});

  @override
  State<TextControl> createState() => TextControlState();
}

class TextControlState extends State<TextControl> {
  var _toggleButtonText = "Change text !";
  var _isToggled = false;

  void toggleText() {
    if (_isToggled) {
      setState(() {
        _isToggled = false;
        _toggleButtonText = "Change it again !";
      });
    } else {
      setState(() {
        _isToggled = true;
        _toggleButtonText = "Go back.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !_isToggled
            ? TextBox(
                widget.initialText,
                boxColor: Colors.orangeAccent.shade400,
              )
            : TextBox(
                widget.toggleText,
                boxColor: Colors.greenAccent,
              ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.blueGrey.shade300),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: toggleText,
          child: Text(_toggleButtonText),
        ),
      ],
    );
  }
}
