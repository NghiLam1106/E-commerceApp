import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/constants/text_string.dart';
import 'package:front_end/presentation/screens/signup/widgets/signup_form.dart';
import 'package:front_end/presentation/widgets/login_signup/form_dividers.dart';
import 'package:front_end/presentation/widgets/login_signup/logo.dart';
import 'package:front_end/presentation/widgets/login_signup/social_buttons.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Logo
              Logo(),

              // Form
              AppFormSignup(),
              const SizedBox(height: AppSizes.spaceBtwInputField),

              // Divider
              AppFormDivider(dividerText: AppTexts.orSignUpWith.capitalize!),
              const SizedBox(height: AppSizes.spaceBtwInputField),

              // Social Buttons
              const AppSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

