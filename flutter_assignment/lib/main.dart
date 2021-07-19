import 'package:flutter/material.dart';

import './text_control.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void changeText() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Assignment"),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 40.0),
          child: TextControl(
            initialText: "Click on the button bellow to change me ! :D",
            toggleText: "Oh look, I have been changed !",
          ),
        ),
      ),
    );
  }
}
