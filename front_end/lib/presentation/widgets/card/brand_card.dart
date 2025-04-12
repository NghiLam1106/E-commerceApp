import 'package:flutter/material.dart';
import 'package:front_end/core/constants/enums.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/brand_model.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:front_end/presentation/widgets/texts/brand_title_and_verify_icon.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder, this.onTap, required this.brand,
  });

  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(AppSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Flexible(
              child: CircularImages(
                isNetworkImage: true,
                image: brand.imageUrl,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
      
            // Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandTitleAndVerifyIcon(title: brand.name, brandTextSize: TextSizes.large),
                ],
                                      
              ),
            ),
          ],
        ),
      ),
    );
  }
}

