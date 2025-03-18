import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/styles/shadows.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';
import 'package:front_end/presentation/widgets/texts/product_price_text.dart';
import 'package:front_end/presentation/widgets/texts/product_title_text.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
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

                  // Sale Tag
                  Positioned(
                      top: 12,
                      child: RoundedContainer(
                          radius: AppSizes.sm,
                          backgroundColor: AppColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.sm, vertical: AppSizes.xs),
                          child: Text(
                            "25%",
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: AppColors.black,
                                ),
                          ))),

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
                  Row(
                    children: [
                      Text("Nike",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(width: AppSizes.xs),
                      const Icon(Iconsax.verify,
                          color: AppColors.primary, size: AppSizes.iconXs)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      const ProductPriceText(price: '35.0',),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(AppSizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: AppSizes.iconLg,
                          height: AppSizes.iconLg,
                          child: Center(
                              child: Icon(
                            Iconsax.add,
                            color: AppColors.white,
                          )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


