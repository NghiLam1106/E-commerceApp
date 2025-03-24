import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
     final dark = AppHelperFunction.isDarkMode(context);
    return Column(
      children: [
        AppSectionHeading(title: 'Payment Method',
        buttonTitle: 'change',
        onPressed: (){}),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            RoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? AppColors.dark : AppColors.white,
              padding: const EdgeInsets.all(AppSizes.sm),
              child: const Image(image: AssetImage(AppImages.google), fit: BoxFit.contain),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems / 2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge,)
          ],
        )
      ],
    );
  }
}