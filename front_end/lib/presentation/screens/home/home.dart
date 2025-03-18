import 'package:flutter/material.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/home/widget/home_appbar.dart';
import 'package:front_end/presentation/screens/home/widget/home_categories.dart';
import 'package:front_end/presentation/screens/home/widget/promo_slider.dart';
import 'package:front_end/presentation/screens/home/widget/search_container.dart';
import 'package:front_end/presentation/widgets/layout/grid_layout.dart';
import 'package:front_end/presentation/widgets/product/product_card/product_card_vertical.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      // Header
      Column(children: [
        //Appbar
        AppbarHome(),

        // Search
        AppSearchContainer(text: "Search in Store"),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // categories
        Padding(
            padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
            child: Column(children: [
              // Heading
              AppSectionHeading(
                title: 'Popular categories',
                showActionButton: false,
                textColor: Colors.black,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              //Categories
              HomeCategories()
            ]))
      ]),

      //body
      Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(children: [
          //Slider
          PromoSlider(
            banners: [
              AppImages.logoLight,
              AppImages.logoLight,
              AppImages.logoLight
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          //Heading
          AppSectionHeading(title: 'Popular Products',onPressed: (){},),
          const SizedBox(height: AppSizes.spaceBtwItems),

          //Popular product
          AppGridLayout(itemCount: 4,itemBuilder: (_,index)=>const ProductCardVertical(),)
        ]),
      )
    ])));
  }
}
