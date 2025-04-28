import 'package:flutter/material.dart';
import 'package:front_end/controller/brand_controller.dart';
import 'package:front_end/controller/category_controller.dart';
import 'package:front_end/controller/order_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/controller/stripe/stripe_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/core/utils/dialog_utils.dart';
import 'package:front_end/model/brand_model.dart';
import 'package:front_end/model/categories_model.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/screens/admin/dashboard/widgets/order_chart.dart';
import 'package:front_end/presentation/screens/admin/dashboard/widgets/grid_dashboard.dart';
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
  final OrderController orderController = OrderController();

  List<ProductModel> _listProducts = [];
  List<BrandModel> _listBrands = [];
  List<CategoryModel> _listCategories = [];
  late Future<Map<String, dynamic>> futureData;
  Future<Map<DateTime, int>>? futureOrderCount7Days; // << thêm dòng này

  @override
  void initState() {
    super.initState();
    _getData();
    futureData = StripeController.getRevenueAndPayments();
    futureOrderCount7Days =
        orderController.getOrderCountLast7Days(); // << thêm dòng này
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
            FutureBuilder<Map<DateTime, int>>(
              future: futureOrderCount7Days,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text('Không thể tải dữ liệu 😥'));
                }
                return OrdersChart(ordersPerDay: snapshot.data!);
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            FutureBuilder<Map<String, dynamic>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('Có lỗi xảy ra 😥'));
                  }

                  final totalRevenue = snapshot.data!['totalRevenue'] ?? 0.0;
                  final successfulPayments =
                      snapshot.data!['successfulPayments'] ?? 0;

                  return Column(
                    children: [
                      Card(
                        color: Colors.blue.shade50,
                        child: ListTile(
                          leading:
                              const Icon(Icons.attach_money_rounded, size: 40),
                          title: const Text('Tổng doanh thu'),
                          subtitle:
                              Text('\$${totalRevenue.toStringAsFixed(2)}'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GridDashboard(
                        brandQuantity: _listBrands.length,
                        categoriesQuantity: _listCategories.length,
                        orderQuantity: successfulPayments,
                        productQuantity: _listProducts.length,
                      ),
                    ],
                  );
                }),
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
                  itemCount:
                      _listProducts.length >= 6 ? 6 : _listProducts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (_listProducts.isEmpty) {
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
