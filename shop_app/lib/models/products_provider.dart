import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../errors/http_exception.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  //var _showFavoritesOnly = false;

  final String? authToken;
  final String userId;

  ProductsProvider(this.authToken, this.userId, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((item) => item.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchProducts([bool filterByUser = false]) {
    final filterString =
        filterByUser ? "&orderBy=\"creatorId\"&equalTo=\"$userId\"" : "";
    var url = Uri.parse(
        "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authToken}$filterString");

    return http.get(url).then((response) async {
      print("RESPONSE ${response.body}");
      final data = json.decode(response.body) as Map<String, dynamic>?;

      url = Uri.parse(
          "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=${authToken}");

      final favoritesResponse = await http.get(url);
      final favoritesData = json.decode(favoritesResponse.body);

      if (data != null) {
        final List<Product> loadedItems = [];
        data.forEach((productId, productData) {
          final product = Product(
            id: productId,
            title: productData["title"] as String,
            description: productData["description"] as String,
            price: productData["price"] as double,
            imageUrl: productData["imageUrl"] as String,
            isFavorite: favoritesData == null
                ? false
                : favoritesData[productId] ?? false,
          );
          loadedItems.insert(0, product);
        });
        _items = loadedItems;
      }
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authToken}");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "price": product.price,
          "creatorId": userId,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)["name"],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> editProduct(String id, Product product) {
    var url = Uri.parse(
        "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=${authToken}");
    print(product.isFavorite);
    return http
        .put(
      url,
      body: json.encode({
        "title": product.title,
        "description": product.description,
        "imageUrl": product.imageUrl,
        "price": product.price,
      }),
    )
        .then((response) {
      final productIndex = _items.indexWhere((product) => product.id == id);
      _items[productIndex] = product;
      notifyListeners();
    });
  }

  void deleteProduct(String id) {
    var url = Uri.parse(
        "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=${authToken}");

    final productIndex = _items.indexWhere((product) => product.id == id);
    Product? product = _items[productIndex];
    _items.removeWhere((product) => product.id == id);

    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException("Could not delete product");
      }
      product = null;
    }).catchError((error) {
      _items.insert(productIndex, product!);
      notifyListeners();
    });
    notifyListeners();
  }
}
