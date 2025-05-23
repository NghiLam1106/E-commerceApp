import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.heigth,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = Colors.white,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = AppSizes.md,
  });

  final double? width, heigth;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: heigth,
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: border,
              color: backgroundColor),
          child: ClipRRect(
              borderRadius: applyImageRadius
                  ? BorderRadius.circular(borderRadius)
                  : BorderRadius.zero,
              child: Image(
                  fit: fit,
                  image: isNetworkImage
                      ? NetworkImage(imageUrl)
                      : AssetImage(imageUrl) as ImageProvider))),
    );
  }
}
