import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/model/user_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Đăng ký người dùng
  Future<void> signUp(
      BuildContext context, String name, String email, String password) async {
    try {
      // Tạo tài khoản với Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lấy UID người dùng
      String uid = userCredential.user!.uid;

      // Tạo đối tượng UserModel
      UserModel newUser =
          UserModel(uid: uid, name: name, email: email, avatar: '');

      // Lưu thông tin vào Firestore (collection: 'users')
      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      // Hiển thị thông báo thành công
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công!')),
      );

      // Chuyển hướng đến màn hình đăng nhập
      // ignore: use_build_context_synchronously
      context.push('/login');
    } catch (e) {
      // Hiển thị lỗi nếu đăng ký thất bại
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }

  // Đăng nhập người dùng
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      // Đăng nhập với Firebase Authentication
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Hiển thị thông báo thành công
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công!')),
      );

      // Chuyển hướng tới trang chủ (HomeScreen) bằng GoRouter
      // ignore: use_build_context_synchronously
      context.push('/');
    } catch (e) {
      // Hiển thị lỗi nếu đăng nhập thất bại
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }

  // Đăng ký bằng google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Hiển thị giao diện đăng nhập Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Nếu người dùng đóng hộp thoại đăng nhập, trả về null
      if (googleUser == null) {
        print("Người dùng đã hủy đăng nhập Google.");
        return; // Không tiếp tục xử lý đăng nhập
      }

      // Lấy xác thực từ Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Tạo thông tin đăng nhập từ Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập với Firebase Authentication
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Lỗi khi đăng nhập Google: $e");
      return; // Trả về null nếu có lỗi
    }
  }

  // Đăng xuất người dùng
  Future<void> signOut(BuildContext context) async {
    final user = _auth.currentUser;
    try {
      // Kiểm tra xem người dùng có đăng nhập bằng Google không
      bool isGoogleUser =
          user!.providerData.any((info) => info.providerId == 'google.com');

      if (isGoogleUser) {
        await GoogleSignIn().signOut(); // Đăng xuất khỏi Google
      }

      await _auth.signOut(); // Đăng xuất khỏi Firebase

      // Hiển thị thông báo
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng xuất thành công!')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }
}
