import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/screens/cart/widgets/cart_item.dart';
import 'package:front_end/presentation/screens/checkout/widgets/billing_address_section.dart';
import 'package:front_end/presentation/screens/checkout/widgets/billing_payment_section.dart';
import 'package:front_end/presentation/screens/checkout/widgets/billing_amount_section.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppbarCustom(
          showBackArrow: true,
          title: Text('Oder Review',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              CartItems(showAddRemoveBtn: false),
              const SizedBox(height: AppSizes.spaceBtwSections),
              RoundedContainer(
                padding: EdgeInsets.all(AppSizes.defaultSpace),
                showBorder: true,
                backgroundColor: dark ? AppColors.black : AppColors.white,
                child: Column(
                  children: [
                    // Pricing
                    BillingAmountSection(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    Divider(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    //Payment method
                    BillingPaymentSection(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    BillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: ElevatedButton(
              onPressed: () => context.push('/success'),
              child: Text('checkout \$236'))),
    );
  }
}
