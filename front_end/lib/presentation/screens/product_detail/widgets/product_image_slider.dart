import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/container/primary_header_container.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Container(
      color: dark ? AppColors.darkerGrey : AppColors.lightGrey,
      child: Stack(
        children: [
          // Main large image
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(AppSizes.productImageRadius * 2), // 32
              child: Center(child: Image(image: AssetImage(AppImages.phone))))),
    
          // image slider
          Positioned(
            right: 0,
            bottom: 30,
            left: AppSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  itemCount: 6,
                  itemBuilder: (_, index) => RoundedImage(
                  imageUrl: AppImages.iphone,
                  width: 80,
                  
                  border: Border.all(color: AppColors.primary),
                  padding: const EdgeInsets.all(AppSizes.sm))),
            ),
          ),
    
          // Appbar
          AppbarCustom(
            showBackArrow: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, color: AppColors.darkerGrey))],
          )
        ],
      ),
    );
  }
}
