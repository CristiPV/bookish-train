import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_provider.dart';
import '../models/product.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final List<Product> products = productsData.items;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
          // id: products[index].id,
          // title: products[index].title,
          // imageUrl: products[index].imageUrl,
        ),
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(10.0),
    );
  }
}
