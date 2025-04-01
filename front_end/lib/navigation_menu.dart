import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/screens/favourite/favourite.dart';
import 'package:front_end/presentation/screens/home/home.dart';
import 'package:front_end/presentation/screens/login/login.dart';
import 'package:front_end/presentation/screens/setting/setting.dart';
import 'package:front_end/presentation/screens/store/store.dart';
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
                      icon: Icon(Iconsax.heart), label: "Favourite"),
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
  final Rxn<User> user = Rxn<User>(); // Theo dõi trạng thái đăng nhập Firebase

  /// Danh sách màn hình thay đổi dựa trên trạng thái đăng nhập
  List<Widget> get screen => [
        HomeScreen(),
        StoreScreen(),
        FavouriteScreen(),
        user.value != null ? SettingScreen() : LoginScreen(), // Nếu đã đăng nhập -> Home, chưa -> Login
      ];

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      user.value = newUser;
    });
  }
}
