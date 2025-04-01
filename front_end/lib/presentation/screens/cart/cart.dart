import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/cart/widgets/cart_item.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
          showBackArrow: true,
          title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        // items in cart
        child: CartItems()
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child:
          ElevatedButton(onPressed: () {context.push('/checkout');}, child: Text('checkout \$236'))),
    );
  }
}
