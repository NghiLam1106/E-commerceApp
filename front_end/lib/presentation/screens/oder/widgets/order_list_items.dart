import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (_, index) => RoundedContainer(
      padding: EdgeInsets.all(AppSizes.md),
      showBorder: true,
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_shipping_outlined),
              SizedBox(width: AppSizes.spaceBtwItems / 2,),

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Processing',
                    style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.primary)
                  ),
                  Text(
                    '07 Nov 2024',
                    style: Theme.of(context).textTheme.headlineSmall
                  ),
                ],
              ),
                ],
              ),

              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios), iconSize: AppSizes.iconSm,)
            ],
          ),
          const SizedBox(width: AppSizes.spaceBtwItems / 2,),

          Row(
            children: [
              Icon(Iconsax.calendar),
              SizedBox(width: AppSizes.spaceBtwItems / 2,),

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping day',
                    style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.primary)
                  ),
                  Text(
                    '07 Nov 2024',
                    style: Theme.of(context).textTheme.headlineSmall
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    )
    );
  }
}