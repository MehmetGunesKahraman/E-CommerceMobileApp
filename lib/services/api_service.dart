import 'dart:convert';

import 'package:fluttapp/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://www.wantapi.com/products.php";

  Future<ProductsModel> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return ProductsModel.fromJson(data);
    } else {
      throw Exception("Error occured while accessing API.");
    }
  }
}
