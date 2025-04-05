import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfileTitle extends StatelessWidget {
  const UserProfileTitle({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future:
          Future.value(FirebaseAuth.instance.currentUser), // Lấy user hiện tại
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final User? user = snapshot.data;
        return ListTile(
          leading: ClipOval(
            child: user?.photoURL != null && user!.photoURL!.isNotEmpty
                ? Image.network(user.photoURL!,
                    width: 50, height: 50, fit: BoxFit.cover)
                : CircularImages(
                    image: AppImages.google,
                    width: 50,
                    height: 50,
                  ),
          ),
          title: Text(
            user?.displayName ?? 'Người dùng',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: AppColors.black),
          ),
          subtitle: Text(
            user?.email ?? 'Chưa có email',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: AppColors.black),
          ),
          trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Iconsax.edit, color: AppColors.darkgrey),
          ),
        );
      },
    );
  }
}
