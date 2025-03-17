import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/text_string.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/product/cart/cart_menu_icon.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return AppbarCustom(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.logo,
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        AppCartCounterIcon(onPressed: (){},iconColor: AppColors.black,)
      ],
    );
  }
}

