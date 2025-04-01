import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/navigation_menu.dart';
import 'package:front_end/presentation/screens/address/add_new_address.dart';
import 'package:front_end/presentation/screens/address/address.dart';
import 'package:front_end/presentation/screens/cart/cart.dart';
import 'package:front_end/presentation/screens/checkout/checkout.dart';
import 'package:front_end/presentation/screens/home/home.dart';
import 'package:front_end/presentation/screens/login/login.dart';
import 'package:front_end/presentation/screens/oder/order.dart';
import 'package:front_end/presentation/screens/product_detail/product_detail.dart';
import 'package:front_end/presentation/screens/profile/profile.dart';
import 'package:front_end/presentation/screens/register/register.dart';
import 'package:front_end/presentation/screens/setting/setting.dart';
import 'package:front_end/presentation/screens/success_screen/success_screen.dart';
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
    GoRoute(
      name: 'address',
      path: '/address',
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      name: 'newAddress',
      path: '/newAddress',
      builder: (context, state) => const AddNewAddressScreen(),
    ),
    GoRoute(
      name: 'cart',
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      name: 'checkout',
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      name: 'myOrder',
      path: '/myOrder',
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      name: 'success',
      path: '/success',
      builder: (context, state) => SuccessScreen(
        image: AppImages.checked,
        title: 'Payment Success!',
        subTitle: 'Your item will be shipped soon',
        onPressed: () => context.go('/'),
      ),
    ),
  ],
);
