import 'package:flutter/material.dart';
import 'package:front_end/controller/auth/auth_controller.dart';
import 'package:front_end/controller/category_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/categories_model.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/screens/home/widget/home_appbar.dart';
import 'package:front_end/presentation/screens/home/widget/home_categories.dart';
import 'package:front_end/presentation/screens/home/widget/promo_slider.dart';
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
  // List Data
  final List<ProductModel> _productsList = [];
  final List<CategoryModel> _categoriesList = [];

  // Controllers
  final ProductController productController = ProductController();
  final CategoryController categoryController = CategoryController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _check();
    _getData();
  }

  void _check() async {
    final auth = AuthController();
    final user = await auth.getUserData();

    if (user != null && user.role == 'admin') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/admin');
      });
    }
  }

Future<void> _getData() async {
  final products = await productController.getProductsListLimit();
  final categories = await categoryController.getCategories();

  if (!mounted) return; // ⛑ Ngăn lỗi nếu widget đã bị dispose

  setState(() {
    _productsList.addAll(products);
    _categoriesList.addAll(categories);
    _isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Column(children: [
                    AppbarHome(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // Categories
                    Padding(
                      padding:
                          const EdgeInsets.only(left: AppSizes.defaultSpace),
                      child: HomeCategories(categories: _categoriesList),
                    ),
                  ]),

                  // Body
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.defaultSpace),
                    child: Column(
                      children: [
                        PromoSlider(
                          banners: [
                            AppImages.slide1,
                            AppImages.slide2,
                            AppImages.slide3,
                            AppImages.slide4,
                          ],
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        AppSectionHeading(
                          title: 'Sản phẩm nổi bật',
                          onPressed: () {},
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        _productsList.isEmpty
                            ? const Center(
                                child: Text("Không có sản phẩm nào."))
                            : AppGridLayout(
                                itemCount: _productsList.length,
                                itemBuilder: (contex, index) {
                                  final product = _productsList[index];
                                  return ProductCardVertical(
                                    product: product,
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
