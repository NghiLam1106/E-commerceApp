import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfileTitle extends StatelessWidget {
  const UserProfileTitle({
    super.key, this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: const CircularImages(image: AppImages.google, width: 50, height: 50, padding: 0),
      title: Text('Username',style: Theme.of(context).textTheme.headlineSmall!.apply(
        color: AppColors.black
      )),
      subtitle: Text('Username@gmail.com',style: Theme.of(context).textTheme.bodyMedium!.apply(
        color: AppColors.black
      )),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,color: AppColors.darkgrey)),
    );
  }
}