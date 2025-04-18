import 'package:flutter/material.dart';
import 'package:front_end/controller/brand_controller.dart';
import 'package:front_end/controller/category_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/core/utils/dialog_utils.dart';
import 'package:front_end/model/brand_model.dart';
import 'package:front_end/model/categories_model.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/screens/admin/dashboard/widgets/grid_dashboard.dart';
import 'package:front_end/presentation/screens/admin/dashboard/widgets/listview_order.dart';
import 'package:front_end/presentation/screens/admin/dashboard/widgets/menu_bar.dart';
import 'package:front_end/presentation/screens/admin/products/widgets/card_product.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ProductController productController = ProductController();
  final BrandController brandController = BrandController();
  final CategoryController categoryController = CategoryController();

  List<ProductModel> _listProducts = [];
  List<BrandModel> _listBrands = [];
  List<CategoryModel> _listCategories = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final products = await productController.getProductsList();
    final brands = await brandController.getBrands();
    final categories = await categoryController.getCategories();
    setState(() {
      _listProducts = products;
      _listBrands = brands;
      _listCategories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppbarCustom(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Dashboard',
              style: TextStyle(
                color: dark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          MenuBarCustom(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grid Dashboard
            GridDashboard(
              brandQuantity: _listBrands.length,
              categoriesQuantity: _listCategories.length,
              orderQuantity: 40,
              productQuantity: _listProducts.length,
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            // 2. Danh sách đơn hàng
            AppSectionHeading(
              title: 'Danh sách đơn hàng',
              onPressed: () {
                //context.push('/admin/product');
              },
            ),

            ListViewOrder(),
            const SizedBox(height: AppSizes.spaceBtwSections),

            AppSectionHeading(
              title: 'Sản phẩm mới nhất',
              onPressed: () {
                context.push('/admin/products');
              },
            ),

            SizedBox(
              height: _listProducts.length * 130,
              child: ListView.builder(
                  itemCount: _listProducts.length >= 6 ? 6 : _listProducts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                   
                    if(_listProducts.isEmpty){
                      return const Center(child: CircularProgressIndicator());
                    }
                    final ProductModel product = _listProducts[index];
                    return GestureDetector(
                      onTap: () {
                          context.push('/admin/products');
                        },
                      child: CardProduct(
                        id: product.id ?? "",
                        name: product.name,
                        categoryId: product.categoryId,
                        price: product.price,
                        imageURL: product.imageUrls[0],
                        onEdit: () {
                          context.push('/admin/products');
                        },
                        onDelete: () => showDeleteConfirmationDialog(
                          context: context,
                          onConfirm: () {
                            productController.removeProduct(product.id ?? '');
                          },
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}


