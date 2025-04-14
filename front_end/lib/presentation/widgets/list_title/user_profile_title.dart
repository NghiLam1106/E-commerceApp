import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/user/user_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfileTitle extends StatelessWidget {
  const UserProfileTitle({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    // Kiểm tra phương thức đăng nhập của người dùng
    bool isGoogleSignIn =
        user!.providerData.any((info) => info.providerId == 'google.com');
    return FutureBuilder<Map<String, dynamic>?>(
      future: isGoogleSignIn
          ? null // Nếu đăng nhập bằng Google, không cần truy vấn Firestore
          : UserController()
              .getUserFromFirestore(user.uid), // Truy vấn dữ liệu từ Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching user data'));
        } else if (snapshot.hasData || isGoogleSignIn) {
          // Dữ liệu người dùng từ Firestore
          var userData = snapshot.data;

          String username = isGoogleSignIn
              ? user.displayName ?? 'No Name'
              : userData?['name'] ?? 'No Name';
          String email = isGoogleSignIn
              ? user.email ?? 'No Email'
              : userData?['email'] ?? 'No Email';
          String productImageUrl = isGoogleSignIn
              ? user.photoURL ?? AppImages.google
              : userData?['avatar'] ?? AppImages.google;

          return ListTile(
            leading: ClipOval(
              child: productImageUrl.isNotEmpty
                  ? Image.network(productImageUrl,
                      width: 50, height: 50, fit: BoxFit.cover)
                  : user.photoURL != null && user.photoURL!.isNotEmpty
                      ? Image.network(user.photoURL!,
                          width: 50, height: 50, fit: BoxFit.cover)
                      : CircularImages(
                          image: AppImages.google,
                          width: 50,
                          height: 50,
                        ),
            ),
            title: Text(
              username,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: AppColors.black),
            ),
            subtitle: Text(
              email,
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
        } else {
          return Center(child: Text('No user data found.'));
        }
      },
    );
  }
}
