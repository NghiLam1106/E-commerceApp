import 'package:flutter/material.dart';
import 'package:front_end/controller/auth/auth_controller.dart';
import 'package:go_router/go_router.dart';

class MenuBarCustom extends StatelessWidget {
  const MenuBarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      onSelected: (value) {
        switch (value) {
          case 'products':
            break;
          case 'categories':
            break;
          case 'brands':
            break;
          case 'logout':
            final authController = AuthController();
            authController.signOut(context);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Sản phẩm',
          child: GestureDetector(
              onTap: () {
                context.push('/admin/products');
              },
              child: Text('Sản phẩm')),
        ),
        PopupMenuItem<String>(
          value: 'Loại sản phẩm',
          child: GestureDetector(
              onTap: () {
                context.push('/admin/categories');
              },
              child: Text('Loại sản phẩm')),
        ),
        PopupMenuItem<String>(
          value: 'Thương hiệu',
          child: GestureDetector(
              onTap: () {
                context.push('/admin/brands');
              },
              child: Text('Thương hiệu')),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text('Đăng xuất'),
        ),
      ],
    );
  }
}
