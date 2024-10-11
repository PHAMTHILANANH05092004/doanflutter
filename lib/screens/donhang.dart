import 'package:flutter/material.dart';
import 'package:ungdungdicho/screens/order_confirmation_screen.dart';
import '../models/cart.dart';

class OrderScreen extends StatefulWidget {
  final Cart cart;

  const OrderScreen({super.key, required this.cart});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng của bạn'),
      ),
      body: widget.cart.items.isEmpty
          ? const Center(child: Text('Giỏ hàng trống'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = widget.cart.items[index];
                      return ListTile(
                        leading: Image.network(cartItem.product.imageUrl),
                        title: Text(cartItem.product.name),
                        subtitle: Text(
                          'Số lượng: ${cartItem.quantity} x ${cartItem.product.price}₫',
                        ),
                        trailing: Column(
                          children: [
                            Text(
                                '${cartItem.product.price * cartItem.quantity}₫'),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      widget.cart.decreaseItemQuantity(
                                          cartItem.product);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      widget.cart.addItem(cartItem.product);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      widget.cart.removeItem(cartItem.product);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tổng tiền: ${widget.cart.getTotalPrice()}₫',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Điều hướng sang trang điền thông tin khách hàng
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomerInfoScreen(cart: widget.cart),
                          ),
                        );
                      },
                      child: const Text('Đặt Hàng'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
