import 'package:flutter/material.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/profile/widgets/profile_menu.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustom(
          showBackArrow: true,
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),

          // Avatar
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Column(children: [
                const CircularImages(
                    image: AppImages.google, width: 80, height: 80),
                TextButton(
                    onPressed: () {}, child: const Text('Change Avatar')),
              ]),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: AppSizes.spaceBtwItems),

            //Details        
            const AppSectionHeading(title: 'Profile Information', showActionButton: false,),
            const SizedBox(height: AppSizes.spaceBtwItems),

            ProfileMenu(onTap: () {  }, value: 'lexuantuyen', title: 'Username'),
            ProfileMenu(onTap: () {  }, value: 'lexuantuyen@gmail.com', title: 'E-mail'),
            ProfileMenu(onTap: () {  }, value: '0123456789', title: 'Phone Number'),
            ProfileMenu(onTap: () {  }, value: 'Hanoi, Vietnam', title: 'Address'),

            
          ]),
        )));
  }
}

