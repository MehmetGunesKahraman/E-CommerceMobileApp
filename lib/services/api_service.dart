import 'dart:convert';

import 'package:fluttapp/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://www.wantapi.com/products.php";
  static const fallbackAssetPath = "assets/products.json";

  Future<ProductsModel> fetchProducts() async {
    try {
        final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductsModel.fromJson(data);
      }

      return _loadFallbackProducts();
    } catch (_) {
      return _loadFallbackProducts();
    }
  }

  Future<ProductsModel> loadLocalProducts() async {
    return _loadFallbackProducts();
  }

  Future<ProductsModel> _loadFallbackProducts() async {
    final jsonString = await rootBundle.loadString(fallbackAssetPath);
    final data = jsonDecode(jsonString);
    return ProductsModel.fromJson(data);
  }
}
