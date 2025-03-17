import 'package:front_end/navigation_menu.dart';
import 'package:front_end/presentation/screens/home/home.dart';
import 'package:go_router/go_router.dart';
import 'package:front_end/presentation/screens/login/login.dart';
import 'package:front_end/presentation/screens/signup/signup.dart';

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
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

  ],
);
