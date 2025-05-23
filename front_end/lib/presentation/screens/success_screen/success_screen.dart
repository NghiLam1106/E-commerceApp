import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image,title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: AppSpacingStyles.paddingWithAppbarHeight *2,
        child: Column(
          children: [
            Image(image: AssetImage(image), width: AppHelperFunction.screenWith() * 0.6),
            const SizedBox(height: AppSizes.spaceBtwSections),

            Text(title, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Text(subTitle, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
            const SizedBox(height: AppSizes.spaceBtwItems), 

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: onPressed, child: const Text('Continute')),
            )           
          ],
        ),),

      ),
    );
  }
}