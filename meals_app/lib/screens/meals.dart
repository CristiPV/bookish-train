import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class MealsScreen extends StatelessWidget {
  static const routeName = "/meals";
  // These are used for Non-named Routes
  // final String categoryId;
  // final String categoryTitle;

  // MealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final categoryTitle = routeArgs["title"] as String;
    final categoryId = routeArgs["id"] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text("Recipes"),
      ),
    );
  }
}
