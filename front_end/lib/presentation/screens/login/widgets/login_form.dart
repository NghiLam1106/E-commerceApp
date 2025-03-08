import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/constants/text_string.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppLoginForm extends StatelessWidget {
  const AppLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
            child: Column(children: [
              // Email
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  label: Text(AppTexts.email),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputField),
              // Password
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  label: Text(AppTexts.password),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputField / 2),

              // Remember Me & Forget Password
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(AppTexts.rememberMe),
                  ],
                ),

                // Forget Password
                TextButton(
                  onPressed: () {},
                  child: const Text(AppTexts.forgetPw),
                )
              ]),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Sign in Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text(AppTexts.signIn))),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // Create Account button
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                       onPressed: () => context.goNamed('signup'),
                      child: const Text(AppTexts.createAccount))),

              const SizedBox(height: AppSizes.spaceBtwSections),
            ])));
  }
}
