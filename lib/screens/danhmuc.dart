import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final String categoryName;

  const ProductScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Text(
          'Sản phẩm trong danh mục: $categoryName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
