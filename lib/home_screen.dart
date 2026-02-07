import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_shop/cart_screen.dart';
import 'package:mini_shop/models/product_model.dart';
import 'package:mini_shop/providers/cart_provider.dart';
import 'package:mini_shop/ui/utils/app_assets.dart';
import 'package:mini_shop/ui/utils/app_colors.dart';
import 'package:mini_shop/ui/utils/app_styles.dart';
import 'package:mini_shop/widget/product_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              int cartCount = 0;

              cartProvider.cartItems.forEach((item) {
                cartCount += item.quantity;
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AppAssets.logo, height: 80, width: 120),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        },

                        child: Stack(
                          children: [
                            Image.asset(
                              AppAssets.shoppinglogo,
                              height: 30,
                              width: 30,
                            ),
                            if (cartCount > 0)
                              Positioned(
                                top: -4,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    cartCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Recommendations", style: AppTextStyles.black16Medium),
                  SizedBox(height: 15),

                  Expanded(
                    child: GridView.builder(
                      itemCount: cartProvider.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 250,
                          ),
                      itemBuilder: (context, index) =>
                          ProductWidget(product: cartProvider.products[index]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
