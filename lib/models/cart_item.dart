import 'package:mini_shop/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
