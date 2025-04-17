import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key, required this.product, required this.color,
  });

  final ProductModel? product;
  final String color;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Row(
      children: [
        RoundedImage(
          isNetworkImage: true,
          imageUrl: product!.imageUrls[0],
          width: 75, heigth: 75, 
          padding: const EdgeInsets.all(AppSizes.sm),
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.light),
        const SizedBox(width: AppSizes.spaceBtwItems),
    
        // title
        Expanded(child: Column( 
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product!.name, style: Theme.of(context).textTheme.bodyLarge),
            Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Màu sắc: ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: color, style: Theme.of(context).textTheme.bodyLarge)
              ])
            )
        ],))
      ],
    );
  }
}
