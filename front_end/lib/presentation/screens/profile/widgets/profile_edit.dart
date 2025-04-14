import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/controller/image/image_controller.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = true;
  File? productImage;
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    user = _auth.currentUser;
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final docRef = _firestore.collection('users').doc(uid);
      final snapshot = await docRef.get();
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          nameController.text = data['name'] ?? '';
          emailController.text = data['email'] ?? '';
          phoneController.text = data['phone'] ?? '';
          addressController.text = data['address'] ?? '';
        }
      } else {
        // Nếu chưa có dữ liệu, đặt mặc định
        nameController.text = '';
        emailController.text = _auth.currentUser?.email ?? '';
        phoneController.text = '';
        addressController.text = '';
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> _saveProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final userData = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'address': addressController.text.trim(),
    };

    final docRef = _firestore.collection('users').doc(uid);
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.update(userData);
    } else {
      await docRef.set(userData);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
    Navigator.pop(context);
  }

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:30), 
              child: Tooltip(
                message: 'Save',
                child: IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _saveProfile,
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                            child: user?.photoURL?.isNotEmpty == true
                                ? Image.network(
                                    user!.photoURL!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return CircularImages(
                                        image: AppImages.google,
                                        width: 50,
                                        height: 50,
                                      );
                                    },
                                  )
                                : productImage != null
                                    ? Image.file(
                                        productImage!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : CircularImages(
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
                                    productImage = imageFile;
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
              ),
      ),
    );
  }
}
