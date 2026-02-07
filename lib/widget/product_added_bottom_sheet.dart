import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mini_shop/cart_screen.dart';
import 'package:mini_shop/models/product_model.dart';
import 'package:mini_shop/ui/utils/app_styles.dart';
import 'package:mini_shop/widget/custom_elevated_button.dart';

class ProductAddedBottomSheet extends StatelessWidget {
  final ProductModel product;

  const ProductAddedBottomSheet({super.key, required this.product});
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Container(
      height: isKeyboardOpen ? MediaQuery.of(context).size.height * 0.8 : null,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.description,
                    style: AppTextStyles.black16Medium,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Added to cart',
                  style: AppTextStyles.grey14Regular.copyWith(fontSize: 16),
                ),
                SizedBox(width: 15),
                Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            SizedBox(height: 15),
            CustomElevatedButton(text: "View Cart", onPressed: () {Navigator.pop(context);   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );}),
            SizedBox(height: 15),
            CustomElevatedButton(
              text: "continue shopping",
              onPressed: () => Navigator.pop(context),
              outlined: true,
            ),
          ],
        ),
      ),
    );
  }
}
