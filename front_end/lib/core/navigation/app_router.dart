import 'package:front_end/presentation/pages/login_page.dart';
import 'package:front_end/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login', // Đường dẫn mặc định khi khởi chạy ứng dụng
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    /* GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailPage(id: id);
      },
    ),*/
  ],
);
