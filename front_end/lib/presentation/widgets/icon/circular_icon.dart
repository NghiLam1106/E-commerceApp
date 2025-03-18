import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    this.height,
    this.width,
    this.size = AppSizes.lg,
    this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.color,
  });

  final double? height, width, size;
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : dark
                ? AppColors.black.withOpacity(0.9)
                : AppColors.white.withOpacity(0.9),
      ),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: size,
          )),
    );
  }
}
