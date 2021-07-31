import 'package:flutter/material.dart';

import './screens/filters.dart';
import './screens/tabs.dart';
import './screens/meals.dart';
import './screens/meal_detail.dart';

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
              headline5: TextStyle(
                fontFamily: "Raleway",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodyText1: TextStyle(
                fontFamily: "Raleway",
                fontSize: 17,
                color: Colors.black,
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
        "/": (context) => TabsScreen(),
        MealsScreen.routeName: (context) => MealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (context) => TabsScreen());
      },
      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (context) => TabsScreen());
      },
    );
  }
}
