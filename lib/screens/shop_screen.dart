import 'package:flutter/material.dart';
import 'package:ungdungdicho/screens/donhang.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import 'package:ungdungdicho/models/cart.dart';

class ShopScreen extends StatefulWidget {
  final Cart cart;

  const ShopScreen({Key? key, required this.cart}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final ApiService apiService = ApiService();
    final fetchedProducts = await apiService.fetchProducts();

    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đi Chợ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderScreen(cart: widget.cart), // Sử dụng đúng
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(product.name),
                        ),
                        Text(
                          '${product.price}₫',
                          style: const TextStyle(color: Colors.green),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.cart.addItem(product);
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.name} đã được thêm vào giỏ hàng!',
                                ),
                              ),
                            );
                          },
                          child: const Text('Thêm vào giỏ'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
