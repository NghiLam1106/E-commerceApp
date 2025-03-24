import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/widgets/product/cart/add_remove_btn.dart';
import 'package:front_end/presentation/widgets/product/cart/cart_item.dart';
import 'package:front_end/presentation/widgets/texts/product_price_text.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveBtn = true});

  final bool showAddRemoveBtn;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: AppSizes.spaceBtwSections),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (_, index) => Column(
            children: [
              CartItem(),
              if(showAddRemoveBtn) const SizedBox(height: AppSizes.spaceBtwItems),

              // Add Remove Button and total price
              if(showAddRemoveBtn)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 70),
                      // Add and remove Btn
                      AddRemoveBtn(),
                    ],
                  ),
                  ProductPriceText(price: '236')
                ],
              ),
            ],
          ),
        );
  }
}