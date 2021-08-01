import 'package:flutter/material.dart';

import './meals_data.dart';
import './screens/filters.dart';
import './screens/tabs.dart';
import './screens/meals.dart';
import './screens/meal_detail.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegetarian": false,
    "vegan": false,
  };
  List<Meal> _availableMeals = MEALS_LIST;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = MEALS_LIST.where((meal) {
        if (_filters["gluten"] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegetarian"] as bool && !meal.isVegetarian) {
          return false;
        }
        if (_filters["vegan"] as bool && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final index = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (index >= 0) {
      setState(() {
        _favoriteMeals.removeAt(index);
      });
    } else {
      setState(() {
        _favoriteMeals.add(MEALS_LIST.singleWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

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
        "/": (context) => TabsScreen(_favoriteMeals),
        MealsScreen.routeName: (context) => MealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (context) =>
            FilterScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
            builder: (context) => TabsScreen(_favoriteMeals));
      },
      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
            builder: (context) => TabsScreen(_favoriteMeals));
      },
    );
  }
}
