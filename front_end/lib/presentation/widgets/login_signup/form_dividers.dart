import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';

class AppFormDivider extends StatelessWidget {
  const AppFormDivider({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(child:  Divider(color: dark ? AppColors.darkgrey: AppColors.grey, thickness: 0.5, indent: 60,endIndent: 5)),
      Text(dividerText,
          style: Theme.of(context).textTheme.labelMedium),
      Flexible(child:  Divider(color: dark ? AppColors.darkgrey: AppColors.grey, thickness: 0.5, indent: 5,endIndent: 60)),
    ]);
  }
}
