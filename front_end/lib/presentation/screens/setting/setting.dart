import 'package:flutter/material.dart';
import 'package:front_end/controller/auth/auth_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/list_title/settings_menu_title.dart';
import 'package:front_end/presentation/widgets/list_title/user_profile_title.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // Appbar
                AppbarCustom(
                  title: Text("Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AppColors.black)),
                ),

                // User Profile
                UserProfileTitle(onPressed: () async {
                  // Chuyển hướng đến trang đăng nhập
                  final result = await context.push('/profile');
                  if (result == true) {
                    setState(
                      () {},
                    ); // Rebuild lại FutureBuilder để fetch dữ liệu mới
                  }
                }),
                const SizedBox(height: AppSizes.spaceBtwItems) // 16
              ],
            ),

            const Divider(),

            //  body
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace), // 24
              // settings list
              child: Column(
                children: [
                  const AppSectionHeading(title: "Cài đặt tài khoản"),
                  const SizedBox(height: AppSizes.spaceBtwItems), // 16
                  SettingsMenuTitle(
                    icon: Iconsax.safe_home,
                    title: 'Địa chỉ',
                    subtitle: 'Thêm, sửa địa chỉ giao hàng.',
                    onTap: () {
                      context.push('/address');
                    },
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: 'Giỏ hàng',
                    subtitle: 'Xem các sản phẩm đã chọn.',
                    onTap: () {
                      context.push('/cart');
                    },
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: 'Đơn đặt hàng',
                    subtitle: 'Lịch sử đặt hàng của bạn.',
                    onTap: () {
                      context.push('/myOrder');
                    },
                  ),

                  // Logout Button
                  const SizedBox(height: AppSizes.spaceBtwSections), // 32
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {
                            final authController = AuthController();
                            authController.signOut(context);
                          },
                          child: const Text('Đăng xuất'))),

                  const SizedBox(height: AppSizes.spaceBtwSections * 2.5), // 80
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
