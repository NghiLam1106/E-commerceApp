import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';

class AddRemoveBtn extends StatelessWidget {
  const AddRemoveBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
      icon: Icons.remove,
      width: 32,
      height: 32,
      size: AppSizes.md,
      color: dark ? AppColors.white : AppColors.black,
      backgroundColor:
          dark ? AppColors.darkerGrey : AppColors.white,
    ),
    const SizedBox(width: AppSizes.spaceBtwItems),
    Text('2', style: Theme.of(context).textTheme.titleSmall),
    const SizedBox(width: AppSizes.spaceBtwItems),
    CircularIcon(
      icon: Icons.add,
      width: 32,
      height: 32,
      size: AppSizes.md,
      color: AppColors.white,
      backgroundColor: AppColors.primary,
    ),
      ],
    );
  }
}
