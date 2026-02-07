import 'package:flutter/material.dart';
import 'package:mini_shop/models/cart_item.dart';
import 'package:mini_shop/models/product_model.dart';
import 'package:mini_shop/ui/utils/app_assets.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> products = [
    ProductModel(
      id: 1,
      image: AppAssets.tv,
      description: 'Samsung 65-Inch Neo QLED 4K Smart TV QA6...',
      price: 32899,
      rating: 4.5,
      reviewCount: 132,
      title: 'Smart TV',
    ),
    ProductModel(
      id: 2,
      image: AppAssets.mac_book,
      description: 'Apple 2025 MacBook Air 13-inch Laptop with....',
      price: 51000,
      rating: 4.5,
      reviewCount: 132,
      title: 'Apple',
    ),
    ProductModel(
      id: 3,
      image: AppAssets.watch,
      description: 'POLAR Ignite 3 GPS Smartwatch iPhone ....',
      price: 19500,
      rating: 4.5,
      reviewCount: 132,
      title: 'Smartwatch',
    ),
    ProductModel(
      id: 4,
      image: AppAssets.airpod,
      description: 'Soundcore by Anker Life Q30 Hybrid Active Noise...',
      price: 3950,
      rating: 4.5,
      reviewCount: 132,
      title: 'Soundcore',
    ),
    ProductModel(
      id: 5,
      image: AppAssets.mobile,
      description: 'HONOR 400 5G Smartphone, 200MP AI ....',
      price: 21999,
      rating: 4.5,
      reviewCount: 132,
      title: 'Smartphone',
    ),
    ProductModel(
      id: 6,
      image: AppAssets.airbod_2,
      description: 'JBL Go 4 Portable Bluetooth Speaker with I...',
      price: 1899,
      rating: 4.5,
      reviewCount: 132,
      title: 'Speaker',
    ),
  ];

  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  void addToCart(ProductModel product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void deleteFromCart(ProductModel product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    _cartItems.removeAt(index);

    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
    }

    notifyListeners();
  }
}
