import 'package:flutter/material.dart';
import 'package:mini_shop/providers/cart_provider.dart';
import 'package:mini_shop/ui/utils/app_assets.dart';
import 'package:mini_shop/ui/utils/app_colors.dart';
import 'package:mini_shop/ui/utils/app_styles.dart';
import 'package:mini_shop/widget/cart_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child:  Icon(Icons.arrow_back_ios_new , color: AppColors.blue,),
        ),
        title: Text("My Cart", style: AppTextStyles.black20SemiBold),
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              int cartCount = 0;
              int totalPrice = 0;
              for (var item in cartProvider.cartItems) {
                cartCount += item.quantity;
                totalPrice += item.quantity * item.product.price;
              }
              print("totalPrice === ${totalPrice}");
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AppAssets.shoppinglogo, height: 30, width: 30),
                    if (cartCount > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            cartCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            if (cartProvider.cartItems.isEmpty) {
              return Center(
                child: Text(
                  "Cart is empty",
                  style: AppTextStyles.black16Medium,
                ),
              );
            }
            int totalPrice = 0;
            for (var item in cartProvider.cartItems) {
              totalPrice += item.quantity * item.product.price;
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Items Total",
                                        style: AppTextStyles.grey14Regular
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        "EGP ${totalPrice}",
                                        style: AppTextStyles.black16Medium,

                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Shipping fee",
                                        style: AppTextStyles.grey14Regular
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        "Free",
                                        style: AppTextStyles.grey14Regular
                                            .copyWith(fontSize: 16 , color: Colors.green , fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: AppTextStyles.grey14Regular
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        "EGP ${totalPrice}",
                                        style: AppTextStyles.black16Medium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Text(
                    '${cartProvider.cartItems.length} Items',
                    style: AppTextStyles.grey14Regular.copyWith(),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return CartWidget(cart: cartProvider.cartItems[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
