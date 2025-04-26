import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/image/image_controller.dart';
import 'package:front_end/model/user_model.dart';

class UserController {
  // Lấy thông tin người dùng từ Firestore
  Future<Map<String, dynamic>?> getUserFromFirestore(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      print('Error getting user from Firestore: $e');
    }
    return null;
  }

  // Cập nhật thông tin người dùng trong Firestore
  Future<void> saveProfile(nameController, emailController, phoneController,
      addressController, productImage, productImageUrl, context) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    String updatedImageUrl = productImageUrl;
    if (productImage != null) {
      ImageController imageService = ImageController();
      updatedImageUrl = await imageService.saveImageLocally(productImage);
    }

    UserModel newUser = UserModel(
      uid: uid,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      avatar: updatedImageUrl,
      role: 'user', // Mặc định là 'user'
    );

    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.update(newUser.toMap());
    } else {
      await docRef.set(newUser.toMap());
    }

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    Navigator.pop(context, true);
  }

  // Lấy thông tin người dùng theo id
  Future<UserModel?> getUserById(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data() as Map<String, dynamic>, uid);
      }
    } catch (e) {
      print('Error getting user from Firestore: $e');
    }
    return null;
  }
}
