import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/container/primary_header_container.dart';
import 'package:front_end/presentation/widgets/list_title/settings_menu_title.dart';
import 'package:front_end/presentation/widgets/list_title/user_profile_title.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:go_router/go_router.dart';

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
                  const SizedBox(height: AppSizes.spaceBtwItems),  // 16
                  SettingsMenuTitle(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delevery address',
                    onTap: () {},
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: 'My cart',
                    subtitle: 'Add, remove products',
                    onTap: () {},
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: () {},
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delevery address.',
                    onTap: () {},
                  ),
                  SettingsMenuTitle(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delevery address.',
                    onTap: () {},
                  ),

                  // Logout Button
                  const SizedBox(height: AppSizes.spaceBtwSections), // 32
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){}, child: const Text('Logout'))
                  ),

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
