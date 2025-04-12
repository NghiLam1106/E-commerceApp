import 'package:flutter/material.dart';
import 'package:front_end/controller/category/category_controller.dart';
import 'package:front_end/controller/product/product_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/constants/text_string.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/model/categories_model.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/screens/search/widgets/search_anchor.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/appbar/tabbar.dart';
import 'package:front_end/presentation/widgets/card/brand_card.dart';
import 'package:front_end/presentation/widgets/layout/grid_layout.dart';
import 'package:front_end/presentation/widgets/product/cart/cart_menu_icon.dart';
import 'package:front_end/presentation/widgets/product/product_card/product_card_vertical.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<CategoryModel> _categoriesList = [];
  final CategoryController categoryController = CategoryController();

  @override
  void initState() {
    super.initState();
    _getProductsList();
  }

  Future<void> _getProductsList() async {
    final categories = await categoryController.getCategories();
    setState(() {
      _categoriesList = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

      if (_categoriesList.isEmpty) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

    return DefaultTabController(
      length: _categoriesList.length,
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
                expandedHeight: 420,
                automaticallyImplyLeading: false,
                backgroundColor: dark ? AppColors.black : AppColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Thanh tìm kiếm
                      SearchAnchorCustom(),
                      const SizedBox(height: AppSizes.spaceBtwSections),

                      // Danh sách thương hiệu nổi bật
                      AppSectionHeading(
                          title: "Thương hiệu nổi bật",
                          showActionButton: true,
                          onPressed: () {}),
                      const SizedBox(height: AppSizes.spaceBtwItems / 1.55),
                      AppGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return const BrandCard(showBorder: true);
                        },
                      )
                    ],
                  ),
                ),
                bottom: AppTabBar(
                  tabs: _categoriesList
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _categoriesList
                .map((category) => CategoryTab(categoryId: category.id))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class CategoryTab extends StatefulWidget {

  final String? categoryId;

  const CategoryTab({super.key, required this.categoryId});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  List<ProductModel> _productsList = [];
  final ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    _getProductsList();
  }

  Future<void> _getProductsList() async {
    final products = await productController.getProductsByCategory(categoryId: widget.categoryId!);
    setState(() {
      _productsList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _productsList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.defaultSpace),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSizes.defaultSpace),
                      child: Column(
                        children: [
                          AppSectionHeading(
                            title: 'Bạn có thể thích',
                            onPressed: () {},
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          AppGridLayout(
                            itemCount: _productsList.length,
                            itemBuilder: (_, index) => ProductCardVertical(
                                product: _productsList[index]),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwSections),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
  }
}
