import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() {
    var url = Uri.parse(
        "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/orders/$userId.json?auth=$authToken");

    return http.get(url).then((response) {
      final data = json.decode(response.body) as Map<String, dynamic>?;
      if (data != null) {
        final List<OrderItem> loadedItems = [];
        data.forEach((orderId, orderData) {
          final orderItem = OrderItem(
            id: orderId,
            dateTime: DateTime.parse(orderData["dateTime"]),
            amount: orderData["amount"],
            products: (orderData["products"] as List<dynamic>).map((cartItem) {
              return CartItem(
                id: cartItem["id"],
                price: cartItem["price"],
                quantity: cartItem["quantity"],
                title: cartItem["title"],
              );
            }).toList(),
          );
          loadedItems.insert(0, orderItem);
        });
        _orders = loadedItems;
      }
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) {
    var url = Uri.parse(
        "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/orders/$userId.json?auth=$authToken");
    final timestamp = DateTime.now();

    return http
        .post(
      url,
      body: json.encode({
        "amount": total,
        "dateTime": timestamp.toIso8601String(),
        "products": cartProducts
            .map((cartProduct) => {
                  "id": cartProduct.id,
                  "title": cartProduct.title,
                  "quantity": cartProduct.quantity,
                  "price": cartProduct.price,
                })
            .toList(),
      }),
    )
        .then((response) {
      orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    });
  }
}
