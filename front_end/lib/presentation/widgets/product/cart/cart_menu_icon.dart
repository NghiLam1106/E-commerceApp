import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


class AppCartCounterIcon extends StatelessWidget {
  const AppCartCounterIcon({
    super.key,required this.iconColor, required this.onPressed,
  });

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
          right: 3,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100)
          ),
        ),)
        
      ],
    );
  }
}
