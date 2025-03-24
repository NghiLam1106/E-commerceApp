import 'package:front_end/navigation_menu.dart';
import 'package:front_end/presentation/screens/home/home.dart';
import 'package:front_end/presentation/screens/login/login.dart';
import 'package:front_end/presentation/screens/product_detail/product_detail.dart';
import 'package:front_end/presentation/screens/profile/profile.dart';
import 'package:front_end/presentation/screens/register/register.dart';
import 'package:front_end/presentation/screens/setting/setting.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NavigationMenu(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      name: 'proflie',
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      name: 'detail',
      path: '/detail',
      builder: (context, state) => const ProductDetailScreen(),
    ),
  ],
);
