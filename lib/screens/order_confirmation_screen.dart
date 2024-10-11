import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import thư viện http
import 'package:ungdungdicho/models/cart.dart';

class CustomerInfoScreen extends StatefulWidget {
  final Cart cart;

  const CustomerInfoScreen({super.key, required this.cart});

  @override
  _CustomerInfoScreenState createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _paymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin khách hàng'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sản phẩm đã chọn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
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
                    trailing: Text(
                      '${cartItem.product.price * cartItem.quantity}₫',
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Tổng tiền: ${widget.cart.getTotalPrice()}₫',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên khách hàng',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                items: const [
                  DropdownMenuItem(
                    value: 'Cash',
                    child: Text('Thanh toán bằng tiền mặt'),
                  ),
                  DropdownMenuItem(
                    value: 'Credit Card',
                    child: Text('Thanh toán bằng thẻ tín dụng'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Phương thức thanh toán',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty ||
                      _addressController.text.isEmpty ||
                      _phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Vui lòng điền đầy đủ thông tin')),
                    );
                  } else {
                    _placeOrder();
                  }
                },
                child: const Text('Xác nhận đặt hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _placeOrder() async {
    if (_nameController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      // Tạo một đối tượng JSON chứa thông tin đơn hàng
      final orderData = {
        'customer_name': _nameController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'payment_method': _paymentMethod,
        'items': widget.cart.items
            .map((item) => {
                  'name': item.product.name,
                  'quantity': item.quantity,
                  'price': item.product.price
                })
            .toList(),
        'total_price': widget.cart.getTotalPrice(),
      };

      // Gửi yêu cầu POST đến API
      final response = await http.post(
        Uri.parse(
            'http://localhost:3000/place_order.php'), // Thay bằng URL của bạn
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(orderData),
      );

      // Xử lý phản hồi
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đặt hàng thành công!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đặt hàng thất bại!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
    }
  }
}
