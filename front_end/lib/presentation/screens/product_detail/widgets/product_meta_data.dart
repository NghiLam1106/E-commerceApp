import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/enums.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:front_end/presentation/widgets/texts/brand_title_and_verify_icon.dart';
import 'package:front_end/presentation/widgets/texts/product_price_text.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({
    super.key, required this.price, required this.title
  });

  final String price;
  final String title;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price
        ProductPriceText(price: price, isLarge: true),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5), // 10

        // Title
        Text(title, style: Theme.of(context).textTheme.titleLarge,),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5), // 10

        // Brand 
        // cần sửa bên admin sẽ chuyển brand trong productModel thành reference
        Row(children: [
              CircularImages(
                image: AppImages.google,
                width: 32,
                height: 32,
                overlayColor: dark ? AppColors.white : AppColors.black,
              ),
              const BrandTitleAndVerifyIcon(
                  title: 'Iphone', brandTextSize: TextSizes.medium)
            ])
      ],
    );
  }
}
