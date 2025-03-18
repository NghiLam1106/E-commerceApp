import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/home/controllers/home_controller.dart';
import 'package:front_end/presentation/widgets/container/circular_container.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';
import 'package:get/get.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(children: [
      CarouselSlider(
          items: banners.map((url) => RoundedImage(imageUrl: url)).toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index))),
      const SizedBox(height: AppSizes.spaceBtwItems),
      Center(
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                AppCircularContainer(
                  width: 20,
                  height: 3,
                  backgroundColor: controller.carousalCurrentIndex.value == i
                      ? Colors.blue
                      : AppColors.grey,
                  margin: const EdgeInsets.only(right: 40),
                )
            ],
          ),
        ),
      )
    ]);
  }
}
