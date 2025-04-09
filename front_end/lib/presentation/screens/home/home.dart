import 'package:flutter/material.dart';
import 'package:front_end/controller/auth/auth_controller.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/home/widget/home_appbar.dart';
import 'package:front_end/presentation/screens/home/widget/home_categories.dart';
import 'package:front_end/presentation/screens/home/widget/promo_slider.dart';
import 'package:front_end/presentation/screens/home/widget/search_container.dart';
import 'package:front_end/presentation/widgets/layout/grid_layout.dart';
import 'package:front_end/presentation/widgets/product/product_card/product_card_vertical.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    @override
  void initState() {
    super.initState();
    _check();
  }

void _check() async {
  final auth = AuthController();
  final user = await auth.getUserData();

  if (user != null && user.role == 'admin') {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/admin/products'); // or context.push if bạn muốn cho phép back
    });
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          // Header
          Column(children: [
            // Appbar
            AppbarHome(),

            // Search
            AppSearchContainer(text: "Search in Store"),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // Categories
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

                // Categories
                HomeCategories()
              ]),
            )
          ]),

          // Body
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(children: [
              // Slider
              PromoSlider(
                banners: [
                  AppImages.logoLight,
                  AppImages.logoLight,
                  AppImages.logoLight
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // Heading
              AppSectionHeading(
                title: 'Popular Products',
                onPressed: () {},
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // Popular product
              AppGridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => const ProductCardVertical(),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
