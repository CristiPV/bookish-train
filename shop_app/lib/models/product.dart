import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) {
    var url = Uri.parse(
        "https://flutter-course-f95c5-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=${token}");
    isFavorite = !isFavorite;
    notifyListeners();
    return http.put(
      url,
      body: json.encode(isFavorite),
    );
  }
}
