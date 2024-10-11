import 'package:flutter/material.dart';
import 'package:ungdungdicho/screens/LoginScreen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: const Text(
              'Đăng nhập',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()), // Màn hình đăng nhập
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.amber),
            title: const Text('Khách hàng thường'),
            subtitle:
                const Text('Bạn cần tích lũy thêm 1 điểm để đạt thành viên'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Add navigation functionality here
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.account_balance_wallet, color: Colors.orange),
            title: const Text('Điểm thành viên'),
            trailing: const Text(
              '0 điểm',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.store, color: Colors.red),
            title: const Text('Chọn cửa hàng khác'),
            subtitle: const Text('Có mặt tại 63 tỉnh thành '),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.percent, color: Colors.red),
            title: const Text('Voucher của tôi'),
            subtitle: const Text('Sử dụng các mã giảm giá đã nhận'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.purple),
            title: const Text('Địa chỉ của tôi'),
            subtitle: const Text('Quản lý địa chỉ nhận hàng'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.facebook, color: Colors.blue),
            title: const Text('Fanpage đặt đồ ăn theo yêu cầu '),
            subtitle: const Text('Facebook Fanpage chăm sóc khách hàng'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.green),
            title: const Text('Giới thiệu về chúng tôi'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.article, color: Colors.purple),
            title: const Text('Điều khoản sử dụng'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.blue),
            title: const Text('Chính sách bảo mật'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
