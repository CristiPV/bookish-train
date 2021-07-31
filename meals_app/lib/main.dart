import 'package:flutter/material.dart';

import './screens/categories.dart';
import './screens/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals app',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent,
        canvasColor: Colors.teal.shade50,
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "Raleway",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              bodyText1: TextStyle(
                fontFamily: "Raleway",
                fontSize: 17,
                color: Colors.blueGrey.shade50,
              ),
              bodyText2: TextStyle(
                fontFamily: "Raleway",
                color: Colors.blueGrey.shade50,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => CategoriesScreen(),
        MealsScreen.routeName: (context) => MealsScreen(),
      }
    );
  }
}
