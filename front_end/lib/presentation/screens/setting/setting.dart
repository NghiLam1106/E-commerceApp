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

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
                UserProfileTitle(onPressed: () {
                      // Chuyển hướng đến trang đăng nhập
                      context.go('/profile');
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
                  const AppSectionHeading(title: "Account settings"),
                  const SizedBox(height: AppSizes.spaceBtwItems), // 16
                  SettingsMenuTitle(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delevery address',
                    onTap: () {context.push('/address');},
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: 'My cart',
                    subtitle: 'Add, remove products',
                    onTap: () {context.push('/cart');},
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: () {context.push('/myOrder');},
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
                          child: const Text('Logout'))),

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
