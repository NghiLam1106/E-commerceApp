import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/image/image_controller.dart';
import 'package:front_end/controller/user/user_controller.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  File? avatarImage;
  String avatarImageUrl = "";
  String username = "";
  String email = "";
  String phone = "";
  String address = "";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppbarCustom(
          showBackArrow: true,
          title: const Text('Edit Profile'),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.only(right: 30), // Thêm khoảng cách bên phải
              child: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  // Lưu thông tin người dùng/
                  UserController().saveProfile(
                      nameController,
                      emailController,
                      phoneController,
                      addressController,
                      avatarImage,
                      avatarImageUrl,
                      context); // Lưu thông tin người dùng
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
          future: UserController().getUserFromFirestore(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // Dữ liệu người dùng từ Firestore
              var userData = snapshot.data;
              username = userData?['name'] ?? '';
              email = userData?['email'] ?? '';
              phone = userData?['phoneNumber'] ?? '';
              address = userData?['address'] ?? '';
              avatarImageUrl = userData?['avatar'] ?? AppImages.google;

              nameController.text = username;
              emailController.text = email;
              phoneController.text = phone;
              addressController.text = address;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          ClipOval(
                            child: avatarImage != null
                                ? Image.file(
                                    avatarImage!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : avatarImageUrl.isNotEmpty
                                    ? Image.network(
                                        avatarImageUrl,
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
                                        : const CircularImages(
                                            image: AppImages.google,
                                            width: 50,
                                            height: 50,
                                          ),
                          ),
                          TextButton(
                              onPressed: () async {
                                // Chọn ảnh từ thư viện
                                ImageController imageController =
                                    ImageController();
                                File? imageFile = await imageController
                                    .imagePicker(); // Chờ lấy ảnh xong
                                if (imageFile != null) {
                                  setState(() {
                                    // Cập nhật UI sau khi có ảnh
                                    avatarImage = imageFile;
                                  });
                                }
                              },
                              child: const Text('Change Avatar')),
                        ],
                      ),
                    ),
                    const Divider(height: 40),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Profile Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Username
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    /// Email
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    /// Phone
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    /// Address
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No user data found.'));
            }
          },
        ),
      ),
    );
  }
}
