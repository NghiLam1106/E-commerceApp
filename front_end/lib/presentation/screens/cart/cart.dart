import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/cart_model.dart';
import 'package:front_end/presentation/screens/cart/widgets/cart_item.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartModel> cartList = [];
  final CartController cartController = CartController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _check();
    _getData();
  }

  Future<void> _check() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
    }
  }

    void snackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bạn chưa thêm sản phẩm nào.')),
    );
  }

    Future<void> _getData() async {
    final data = await cartController.getUserCartFuture(user!.uid);
    final dataNotPaid = data.where((e) => e.paid == false).toList();
    setState(() {
      cartList = dataNotPaid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        showBackArrow: true,
        title:
            Text('Giỏ hàng', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: CartItems(), // Hiển thị danh sách sản phẩm trong giỏ hàng
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: cartList.isEmpty ? () => snackbar(): () {
            context.push('/checkout');
          },
          child: const Text('Thánh toán'),
        ),
      ),
    );
  }
}
