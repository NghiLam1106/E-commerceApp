import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:go_router/go_router.dart';

class GridDashboard extends StatelessWidget {
  const GridDashboard({
    super.key,
    required this.orderQuantity,
    required this.productQuantity,
    required this.brandQuantity,
    required this.categoriesQuantity
  });

  final int orderQuantity;
  final int productQuantity;
  final int brandQuantity;
  final int categoriesQuantity;

  @override
  Widget build(BuildContext context) {
    final List<_DashboardItem> _dashboardItems = [
      _DashboardItem(
        icon: Icons.shopping_cart,
        label: 'Đơn hàng',
        count: orderQuantity.toString(),
        color: Colors.blueAccent,
        route: '/admin',
      ),
      _DashboardItem(
        icon: Icons.category,
        label: 'Danh mục',
        count: categoriesQuantity.toString(),
        color: Colors.orangeAccent,
        route: '/admin/categories',
      ),
      _DashboardItem(
        icon: Icons.branding_watermark,
        label: 'Thương hiệu',
        count: brandQuantity.toString(),
        color: Colors.green,
        route: '/admin/brands',
      ),
      _DashboardItem(
        icon: Icons.inventory,
        label: 'Sản phẩm',
        count: productQuantity.toString(),
        color: Colors.deepPurple,
        route: '/admin/products',
      ),
    ];
    return GridView.builder(
      itemCount: _dashboardItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSizes.spaceBtwItems,
        crossAxisSpacing: AppSizes.spaceBtwItems,
        mainAxisExtent: 130,
      ),
      itemBuilder: (_, index) {
        final item = _dashboardItems[index];
        return GestureDetector(
          onTap: () => context.push(item.route),
          child: RoundedContainer(
            backgroundColor: item.color.withOpacity(0.1),
            showBorder: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: 40, color: item.color),
                const SizedBox(height: 10),
                Text(item.label,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text(item.count,
                    style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DashboardItem {
  final IconData icon;
  final String label;
  final String count;
  final Color color;
  final String route;

  _DashboardItem({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.route,
  });
}
