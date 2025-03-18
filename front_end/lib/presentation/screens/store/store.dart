import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/constants/text_string.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/screens/home/widget/search_container.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/appbar/tabbar.dart';
import 'package:front_end/presentation/widgets/card/brand_card.dart';
import 'package:front_end/presentation/widgets/layout/grid_layout.dart';
import 'package:front_end/presentation/widgets/product/cart/cart_menu_icon.dart';
import 'package:front_end/presentation/widgets/product/product_card/product_card_vertical.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppbarCustom(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.logo,
                style: TextStyle(
                  color: dark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          actions: [
            AppCartCounterIcon(
              onPressed: () {},
              iconColor: AppColors.black,
            )
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 440,
                    automaticallyImplyLeading: false,
                    backgroundColor: dark ? AppColors.black : AppColors.white,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(AppSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // Search bar
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          const AppSearchContainer(
                            text: "Search in store",
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: AppSizes.spaceBtwSections),
                          //Featured Brands
                          AppSectionHeading(
                              title: "Featured Brands",
                              showActionButton: true,
                              onPressed: () {}),
                          const SizedBox(height: AppSizes.spaceBtwItems / 1.55),
                          // Brand grid
                          AppGridLayout(
                              itemCount: 4,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                return BrandCard(showBorder: true);
                              })
                        ],
                      ),
                    ),
                    bottom: AppTabBar(
                      tabs: const [
                        Tab(child: Text('tab 1')),
                        Tab(child: Text('tab 1')),
                        Tab(child: Text('tab 1')),
                        Tab(child: Text('tab 1')),
                      ],
                    )),
              ];
            },
            body: TabBarView(children: [
              Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: Column(children: [
                    ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.all(AppSizes.defaultSpace),
                            child: Column(
                              children: [
                                AppGridLayout(
                                itemCount: 6,
                                itemBuilder: (_, index) =>
                                    ProductCardVertical()),
                                const SizedBox(height: AppSizes.spaceBtwSections),
                              ],
                            )
                                  
                          )
                        ])
                  ]))
            ])),
      ),
    );
  }
}
