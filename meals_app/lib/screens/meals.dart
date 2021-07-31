import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';
import '../meals_data.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = "/meals";

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late String _categoryTitle;
  late String _categoryId;
  late List<Meal> _categoryMeals;
  var _loadedData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      _categoryTitle = routeArgs["title"] as String;
      _categoryId = routeArgs["id"] as String;
      _categoryMeals = MEALS_LIST
          .where((meal) => meal.categories.contains(_categoryId))
          .toList();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _categoryMeals[index].id,
            title: _categoryMeals[index].title,
            imageUrl: _categoryMeals[index].imageUrl,
            duration: _categoryMeals[index].duration,
            complexity: _categoryMeals[index].complexity,
            affordability: _categoryMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: _categoryMeals.length,
      ),
    );
  }
}
