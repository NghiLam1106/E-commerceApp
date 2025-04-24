import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final darkMode = AppHelperFunction.isDarkMode(context);
    final String currentLocation = GoRouterState.of(context).uri.toString();

    int currentIndex = _getCurrentIndex(currentLocation);

    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        height: 88,
        elevation: 0,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onTabTapped(context, index),
        indicatorColor: darkMode
            ? AppColors.white.withOpacity(0.1)
            : AppColors.black.withOpacity(0.1),
        backgroundColor: darkMode ? AppColors.black : AppColors.white,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Trang chủ"),
          NavigationDestination(icon: Icon(Iconsax.shop), label: "Tìm kiếm"),
          NavigationDestination(icon: Icon(Iconsax.heart), label: "Yêu thích"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Hồ sơ"),
        ],
      ),
    );
  }

  // Xác định tab hiện tại dựa trên location của GoRouter
  int _getCurrentIndex(String location) {
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/favourite')) return 2;
    if (location.startsWith('/settings') ||
        location.startsWith('/signup') ||
        location.startsWith('/login')) {
      return 3;
    }
    return 0; // Mặc định là Home
  }

  // Điều hướng đến tab mới khi chọn trên BottomNavigationBar
  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.push('/');
        break;
      case 1:
        context.push('/search');
        break;
      case 2:
        context.push('/favourite');
        break;
      case 3:
        FirebaseAuth.instance.currentUser != null
            ? context.push('/settings')
            : context.push('/login');
        break;
    }
  }
}
