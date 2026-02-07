import 'package:flutter/material.dart';
import 'package:mini_shop/models/cart_item.dart';
import 'package:mini_shop/models/product_model.dart';
import 'package:mini_shop/providers/cart_provider.dart';
import 'package:mini_shop/ui/utils/app_assets.dart';
import 'package:mini_shop/ui/utils/app_colors.dart';
import 'package:mini_shop/ui/utils/app_styles.dart';
import 'package:mini_shop/widget/product_added_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final cartItem = cartProvider.cartItems.firstWhere(
          (item) => item.product.id == product.id,
          orElse: () => CartItem(product: product, quantity: 0),
        );
        return Container(
          decoration: BoxDecoration(
            color: Colors.white , 
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFEBEBEB),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Image.asset(product.image, width: 120, height: 100),
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(10),
               child: Column(
                 children: [
                   Text(
                     product.description,
                     style: AppTextStyles.black14Medium.copyWith(fontSize: 12),
                   ),
                   SizedBox(height: 5),
                   Row(
                     children: [
                       Icon(Icons.star, color: Color(0xFFFFC039)),
                       Text(
                         '${product.rating} (${product.reviewCount} reviews)',
                         style: AppTextStyles.grey12Regular.copyWith(fontSize: 10),
                       ),
                     ],
                   ),
                   SizedBox(height: 5),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         '${product.price} EGP',
                         style: AppTextStyles.black16Medium,
                       ),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(color: AppColors.offWhite),
                         ),
                         child: cartItem.quantity > 0
                             ? Row(
                           children: [
                             GestureDetector(
                               onTap: () {
                                 cartProvider.removeFromCart(product);
                               },
                               child: Container(
                                 padding: EdgeInsets.all(2),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: AppColors.offWhite,
                                 ),
                                 child: Icon(
                                   Icons.remove,
                                   color: AppColors.grey,
                                   size: 16,
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
                                       (item) => item.product.id == product.id,
                                   orElse: () => CartItem(
                                     product: product,
                                     quantity: 0,
                                   ),
                                 )
                                     .quantity
                                     .toString(),style: TextStyle( color: AppColors.blue,),
                               ),
                             ),

                             GestureDetector(
                               onTap: () {
                                 cartProvider.addToCart(product);
                               },
                               child: Container(
                                 padding: EdgeInsets.all(2),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: AppColors.blue,
                                 ),
                                 child: Icon(
                                   Icons.add,
                                   color: Colors.white,
                                   size: 16,
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
                               builder: (_) =>
                                   ProductAddedBottomSheet(product: product),
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
             )
            ],
          ),
        );
      },
    );
  }
}
