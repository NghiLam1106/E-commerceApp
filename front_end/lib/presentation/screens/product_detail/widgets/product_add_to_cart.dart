import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';

class ProductAddToCart extends StatelessWidget {
  const ProductAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace, vertical: AppSizes.defaultSpace),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadiusLg), // 16
          topRight: Radius.circular(AppSizes.cardRadiusLg), // 16
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            // minus button
            CircularIcon(
                icon: Icons.remove,
                backgroundColor: AppColors.darkgrey,
                width: 40,
                height: 40,
                color: AppColors.white),
            const SizedBox(width: AppSizes.spaceBtwItems), // 16
            // quantity
            Text('1', style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(width: AppSizes.spaceBtwItems), // 16
            // plus button
            CircularIcon(
                icon: Icons.add,
                backgroundColor: AppColors.black,
                width: 40,
                height: 40,
                color: AppColors.white),
          ]),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(AppSizes.md), // 16
              backgroundColor: AppColors.black,
              side: const BorderSide(color: AppColors.black),
            ),
            child: const Text('Add to cart'),)
        ],
      ),
    );
  }
}
