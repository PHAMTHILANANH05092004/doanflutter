import 'package:flutter/material.dart';
import 'package:ungdungdicho/models/cart.dart';
import 'screens/manhinhchinh.dart';
import 'screens/donhang.dart';
import 'screens/shop_screen.dart';
import 'screens/notification_screen.dart';
import 'package:ungdungdicho/screens/taikhoan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng đi chợ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Khởi tạo giỏ hàng
  final Cart cart = Cart();
  int _selectedIndex = 0;

  // Cập nhật danh sách màn hình và truyền cart vào OrderScreen
  List<Widget> _widgetOptions() {
    return <Widget>[
      HomeScreen(),
      OrderScreen(cart: cart),
      ShopScreen(
        cart: cart,
      ),
      NotificationScreen(),
      AccountScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đi Chợ Online'),
      ),
      body: _widgetOptions()
          .elementAt(_selectedIndex), // Hiển thị màn hình theo chỉ mục
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.grey),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, color: Colors.grey),
            label: 'Đi chợ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.grey),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.grey),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: const Color.fromARGB(255, 224, 222, 222),
        onTap: _onItemTapped,
      ),
    );
  }
}
