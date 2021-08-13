import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../models/products_provider.dart';
import '../models/auth.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductItem extends StatefulWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({required this.id, required this.title, required this.imageUrl});
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authToken = Provider.of<Auth>(context, listen: false).token;
    final userId = Provider.of<Auth>(context, listen: false).userId;

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: product.id,
                  );
                },
                child: FadeInImage(
                  placeholder:
                      AssetImage("assets/images/product-placeholder.png"),
                  image: NetworkImage(
                    product.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    product.toggleFavorite(authToken!, userId).then((_) {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  },
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  product.title,
                  textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                  onPressed: () {
                    cart.addItem(product.id, product.price, product.title);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Added item to the cart !",
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          },
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          );
  }
}
