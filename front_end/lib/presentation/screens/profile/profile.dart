import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/user/user_controller.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/profile/widgets/profile_menu.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File? productImage;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(child: Text('No user signed in.')),
      );
    }

    // Kiểm tra phương thức đăng nhập của người dùng
    bool isGoogleSignIn =
        user.providerData.any((info) => info.providerId == 'google.com');

    return Scaffold(
      appBar: AppbarCustom(
        showBackArrow: true,
        title: Text('Hồ sơ'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 30), // Thêm khoảng cách bên phải
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await context.push('/profileEdit');
                if (result == true) {
                  setState(
                    () {},
                  ); // Rebuild lại FutureBuilder để fetch dữ liệu mới
                }
              },
            ),
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: isGoogleSignIn
            ? null // Nếu đăng nhập bằng Google, không cần truy vấn Firestore
            : UserController().getUserFromFirestore(
                user.uid), // Truy vấn dữ liệu từ Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData || isGoogleSignIn) {
            // Dữ liệu người dùng từ Firestore
            var userData = snapshot.data;

            String username = isGoogleSignIn
                ? user.displayName ?? 'No Name'
                : userData?['name'] ?? 'No Name';
            String email = isGoogleSignIn
                ? user.email ?? 'No Email'
                : userData?['email'] ?? 'No Email';
            String phone = isGoogleSignIn
                ? user.phoneNumber ?? 'No phone number'
                : userData?['phoneNumber'] ?? 'No phone number';
            String address = isGoogleSignIn
                ? (userData?['address'] ?? 'No address')
                : (userData?['address'] ?? 'No address');
            String productImageUrl = isGoogleSignIn
                ? (user.photoURL ?? 'No image')
                : (userData?['avatar'] ?? 'No image');

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Avatar
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          ClipOval(
                            child: productImageUrl.isNotEmpty
                                ? Image.network(
                                    productImageUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : user.photoURL != null &&
                                        user.photoURL!.isNotEmpty
                                    ? Image.network(user.photoURL!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover)
                                    : CircularImages(
                                        image: AppImages.google,
                                        width: 50,
                                        height: 50,
                                      ),
                          ),
                          // TextButton(
                          //     onPressed: () async {
                          //       // Chọn ảnh từ thư viện
                          //       ImageController imageController =
                          //           ImageController();
                          //       File? imageFile = await imageController
                          //           .imagePicker(); // Chờ lấy ảnh xong
                          //       if (imageFile != null) {
                          //         setState(() {
                          //           // Cập nhật UI sau khi có ảnh
                          //           productImage = imageFile;
                          //         });
                          //       }
                          //     },
                          //     child: const Text('Change Avatar')),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems / 2),
                    const Divider(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // Details
                    const AppSectionHeading(
                      title: 'Thông tin người dùng',
                      showActionButton: false,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // Hiển thị thông tin người dùng từ Firestore
                    ProfileMenu(
                        onTap: () {}, value: username, title: 'Tên người dùng'),
                    ProfileMenu(onTap: () {}, value: email, title: 'E-mail'),
                    ProfileMenu(
                        onTap: () {}, value: phone, title: 'Số điện thoại'),
                    ProfileMenu(onTap: () {}, value: address, title: 'Địa chỉ'),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No user data found.'));
          }
        },
      ),
    );
  }
}
