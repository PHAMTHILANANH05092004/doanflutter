import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  List<CartItem> items = [];

  void addItem(Product product) {
    for (var item in items) {
      if (item.product.name == product.name) {
        item.quantity += 1;
        return;
      }
    }
    items.add(CartItem(product: product));
  }

  void removeItem(Product product) {
    items.removeWhere((item) => item.product.name == product.name);
  }

  void decreaseItemQuantity(Product product) {
    for (var item in items) {
      if (item.product.name == product.name) {
        if (item.quantity > 1) {
          item.quantity -= 1;
        } else {
          removeItem(product); // Xóa sản phẩm nếu số lượng là 1
        }
        return;
      }
    }
  }

  double getTotalPrice() {
    return items.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}
