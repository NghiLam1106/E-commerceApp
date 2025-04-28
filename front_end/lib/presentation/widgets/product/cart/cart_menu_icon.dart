import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/model/cart_model.dart'; // nếu có
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppCartCounterIcon extends StatelessWidget {
  const AppCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.onPressed,
  });

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final cartController = CartController();

    return StreamBuilder<List<CartModel>>(
      stream: uid != null ? cartController.getUserCart(uid) : Stream.value([]),
      builder: (context, snapshot) {
        final hasCartItems = snapshot.hasData && snapshot.data!.isNotEmpty;

        return Stack(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(Iconsax.shopping_bag, color: iconColor),
            ),
            if (hasCartItems)
              Positioned(
                right: 3,
                top: 3,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
