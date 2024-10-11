import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart'; // Đường dẫn tới lớp Product

class ApiService {
  // Hàm để lấy dữ liệu từ tệp JSON
  Future<List<Product>> fetchProducts() async {
    // Đọc nội dung file JSON
    final String response = await rootBundle.loadString('lib/data/data.json');

    //  dữ liệu JSON
    final List<dynamic> data = json.decode(response);

    // Ánh xạ dữ liệu vào danh sách các đối tượng Product
    return data.map((json) => Product.fromJson(json)).toList();
  }
}
