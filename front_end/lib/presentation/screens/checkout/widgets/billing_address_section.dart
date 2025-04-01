import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeading(title: 'Shipping Address', buttonTitle: 'Change',onPressed: (){},),
        Text('Username', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: AppSizes.spaceBtwItems/2),
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.darkerGrey, size: 16),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text('+84 09999999', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems/2),
        Row(
          children: [
            const Icon(Icons.location_city, color: AppColors.darkerGrey, size: 16),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text('dia chi', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,),
          ],
        ),
      ],
    );
  }
}