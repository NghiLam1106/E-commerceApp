import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/enums.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/styles/shadows.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';
import 'package:front_end/presentation/widgets/texts/brand_title_and_verify_icon.dart';
import 'package:front_end/presentation/widgets/texts/product_price_text.dart';
import 'package:front_end/presentation/widgets/texts/product_title_text.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        context.push('/detail');
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark ? AppColors.darkerGrey : AppColors.white,
        ),
        child: Column(
          children: [
            // Thumbnail, Favourite Icon Button, Sale Tag
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image
                  const RoundedImage(
                      imageUrl: AppImages.iphone, applyImageRadius: true),

                  // Favourite Icon Button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: CircularIcon(
                        icon: Iconsax.heart,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),

            // Detail
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTitleText(title: 'Iphone 16', smallSize: true),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  BrandTitleAndVerifyIcon(title: 'Iphone',),
                ],
              ),
            ),
            const Spacer(),
            //Price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Padding(
                  padding: EdgeInsets.only(left: AppSizes.sm),
                  child: const ProductPriceText(
                    price: '35.0',
                  ),
                ),

                //Add to cart button
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.cardRadiusMd),
                      bottomRight: Radius.circular(AppSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: AppSizes.iconLg,
                    height: AppSizes.iconLg,
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: AppColors.white,
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

