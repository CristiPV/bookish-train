import 'package:flutter/material.dart';
import 'package:meals_app/widgets/category_item.dart';

import '../category_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: CATEGORY_LIST
          .map((category) => CategoryItem(
                id: category.id,
                title: category.title,
                color: category.color,
                key: ValueKey(category.id),
              ))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
