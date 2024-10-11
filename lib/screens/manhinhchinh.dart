import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import 'danhmuc.dart';

// Định nghĩa màn hình chính
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Lớp State cho màn hình chính
class _HomeScreenState extends State<HomeScreen> {
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nhập để tìm kiếm...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Tiêu đề cho danh mục
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Danh mục hàng hóa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Thêm màn hình danh mục vào đây
          CategoryGridScreen(),
          // Phần hiển thị sản phẩm
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  shrinkWrap:
                      true, // Giúp GridView có kích thước phù hợp với nội dung
                  physics:
                      const NeverScrollableScrollPhysics(), // Ngăn cuộn khi nằm trong SingleChildScrollView
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      imageUrl: products[index].imageUrl,
                      label: products[index].name,
                    );
                  },
                ),
        ],
      ),
    );
  }
}

// Định nghĩa lớp Category và CategoryGridScreen bên dưới HomeScreen
class Category {
  final String name;
  final String iconPath;

  Category(this.name, this.iconPath);
}

class CategoryGridScreen extends StatelessWidget {
  final List<Category> categories = [
    Category('Lợn, Bò, Gà, Cá', 'lib/assets/lonboca.jpg'),
    Category('Thủy, Hải Sản', 'lib/assets/dâuwnnuocmawn.jpg'),
    Category('Rau, Củ, Quả', 'lib/assets/Gaomymien.jpg'),
    Category('Rau, Củ Gia Vị', 'lib/assets/raucuqua.jpg'),
    Category('Trái Cây', 'lib/assets/thuyhaisan.jpg'),
    Category('Trứng, Đậu, Bún, Dưa cà', 'lib/assets/trungdaubunduaca.jpg'),
    Category('Gạo, Mỳ, Miến', 'lib/assets/traicay.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 3 cột
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: categories.length,
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // Ngăn cuộn trong SingleChildScrollView
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              // Chuyển sang màn hình sản phẩm
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    categoryName: category.name,
                  ),
                ),
              );
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    category.iconPath,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
