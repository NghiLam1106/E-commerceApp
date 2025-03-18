import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/screens/home/home.dart';
import 'package:front_end/presentation/screens/login/login_page.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = AppHelperFunction.isDarkMode(context);

    return Scaffold(
        bottomNavigationBar: Obx(() => NavigationBar(
                height: 88,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                indicatorColor: darkMode
                    ? AppColors.white.withOpacity(0.1)
                    : AppColors.black.withOpacity(0.1),
                backgroundColor: darkMode ? AppColors.black : AppColors.white,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Iconsax.home), label: "Home"),
                  NavigationDestination(
                      icon: Icon(Iconsax.shop), label: "Store"),
                  NavigationDestination(
                      icon: Icon(Iconsax.heart), label: "Wishlist"),
                  NavigationDestination(
                      icon: Icon(Iconsax.user), label: "Profile"),
                ])),
        body: Obx(
          () => controller.screen[controller.selectedIndex.value],
        ));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = [
    HomeScreen(),
    Container(color: Colors.black),
    Container(color: Colors.white),
    LoginScreen(),
  ];
}
