import 'package:flutter/material.dart';
import 'package:mini_shop/models/cart_item.dart';
import 'package:mini_shop/models/product_model.dart';
import 'package:mini_shop/providers/cart_provider.dart';
import 'package:mini_shop/ui/utils/app_assets.dart';
import 'package:mini_shop/ui/utils/app_colors.dart';
import 'package:mini_shop/ui/utils/app_styles.dart';
import 'package:mini_shop/widget/product_added_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  final CartItem cart;

  const CartWidget({super.key, required this.cart});
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        ProductModel product = cart.product;

        return Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Image.asset(product.image, width: 70, height: 70),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                product.title,
                                style: AppTextStyles.black14Medium.copyWith(),
                              ),
                              Text(
                                product.description,
                                style: AppTextStyles.grey14Regular.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => cartProvider.deleteFromCart(product),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price * cart.quantity} EGP',
                          style: AppTextStyles.black16Medium,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.offWhite),
                          ),
                          child: cart.quantity > 0
                              ? Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.removeFromCart(product);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: AppColors.offWhite,
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: AppColors.grey,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        cartProvider.cartItems
                                            .firstWhere(
                                              (item) =>
                                                  item.product.id == product.id,
                                              orElse: () => CartItem(
                                                product: product,
                                                quantity: 0,
                                              ),
                                            )
                                            .quantity
                                            .toString(),
                                        style: TextStyle(color: AppColors.blue),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.addToCart(product);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: AppColors.blue,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    cartProvider.addToCart(product);
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                      builder: (_) => ProductAddedBottomSheet(
                                        product: product,
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    AppAssets.shoppingadd,
                                    height: 20,
                                    width: 20,
                                    color: AppColors.blue,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
