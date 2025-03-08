import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/constants/text_string.dart';
import 'package:front_end/presentation/screens/login/widgets/login_form.dart';
import 'package:front_end/presentation/styles/spacing_styles.dart';
import 'package:front_end/presentation/widgets/login_signup/form_dividers.dart';
import 'package:front_end/presentation/widgets/login_signup/social_buttons.dart';
import 'package:get/get_utils/get_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
      child: Padding(
        padding: AppSpacingStyles.paddingWithAppbarHeight,
        child: Column(
          children: [
            // Form
            AppLoginForm(),

            //Divider
            AppFormDivider(dividerText: AppTexts.orSignInWith.capitalize!),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // Footer
            AppSocialButtons(),
          ],
        ),
      ),
    ));
  }
}
