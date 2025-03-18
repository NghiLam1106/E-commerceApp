import 'package:flutter/material.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(dark ? AppImages.logoDark : AppImages.logoLight),
          width: 160,
          height: 140,
        )
      ],
    );
  }
}
