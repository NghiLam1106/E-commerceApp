import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';
import 'package:front_end/presentation/widgets/texts/brand_title_and_verify_icon.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Row(
      children: [
        RoundedImage(
          imageUrl: AppImages.iphone,
          width: 60, heigth: 60, 
          padding: const EdgeInsets.all(AppSizes.sm),
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.light),
        const SizedBox(height: AppSizes.spaceBtwItems),
    
        // title, price
        Expanded(child: Column( 
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BrandTitleAndVerifyIcon(title: 'iphone'),
            Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Color:', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: 'White', style: Theme.of(context).textTheme.bodyLarge)
              ])
            )
        ],))
      ],
    );
  }
}
