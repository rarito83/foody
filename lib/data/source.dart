import 'dart:convert';

import 'package:foody/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final List<ProductModel> _list = [];

  Future<dynamic> getAllProducts() async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/52c41978-6e31-4ea3-b917-01899e3ed373'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (Map<String, dynamic> x in data) {
        _list.add(ProductModel.fromJson(x));
      }
      return _list;
    } else {
      throw Exception('Failed get data all products!');
    }
  }
}
