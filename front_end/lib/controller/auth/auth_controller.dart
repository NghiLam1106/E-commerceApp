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

      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload(); // Tải lại dữ liệu người dùng

      // Lấy UID người dùng
      String uid = userCredential.user!.uid;

      // Tạo đối tượng UserModel
      UserModel newUser = UserModel(
        uid: uid,
        name: name,
        email: email,
        avatar: '',
        phoneNumber: '',
        address: '',
        role: 'user', // Mặc định là 'user'
      );

      // Lưu thông tin vào Firestore (collection: 'users')
      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      // Hiển thị thông báo thành công
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công!')),
      );

      // Chuyển hướng đến màn hình đăng nhập
      // ignore: use_build_context_synchronously
      context.pop();
    } catch (e) {
      // Hiển thị lỗi nếu đăng ký thất bại
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: Đăng ký không thành công')),
      );
    }
  }

  // Đăng nhập người dùng
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      // Đăng nhập với Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lấy UID người dùng
      String uid = userCredential.user!.uid;

      // Lấy dữ liệu người dùng từ Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Kiểm tra và lấy trường 'role'
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final String role = userData['role'] ?? 'user'; // Giá trị mặc định

        // In ra hoặc dùng role (tuỳ theo mục đích)
        print('Vai trò người dùng: $role');

        // Có thể chuyển hướng tùy theo vai trò
        if (role == 'admin') {
          // ignore: use_build_context_synchronously
          // Đợi 1 frame để tránh bị lock
          if (!context.mounted) return;
          Navigator.of(context).pushReplacementNamed('/admin');
        } else {
          // Chuyển hướng tới trang chủ (HomeScreen) bằng GoRouter
          // ignore: use_build_context_synchronously
          context.push('/');
        }
      }

      // Hiển thị thông báo thành công
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công!')),
      );
    } catch (e) {
      // Hiển thị lỗi nếu đăng nhập thất bại
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: Đăng nhập không thành công')),
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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Lấy thông tin người dùng
      User? user = userCredential.user;

      if (user != null) {
        String name = user.displayName ?? '';
        String email = user.email ?? '';

        // Lấy UID người dùng
        String uid = userCredential.user!.uid;

        // Tạo đối tượng UserModel
        UserModel newUser = UserModel(
          uid: uid,
          name: name,
          email: email,
          avatar: '',
          phoneNumber: '',
          address: '',
          role: 'user', // Mặc định là 'user'
        );

        final doc = await _firestore.collection('users').doc(uid).get();
        if (!doc.exists) {
          await _firestore.collection('users').doc(uid).set(newUser.toMap());
        }

        // Hiển thị thông báo thành công
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập thành công!')),
        );

        // Chuyển hướng tới trang chủ (HomeScreen) bằng GoRouter
        // ignore: use_build_context_synchronously
        context.push('/');
      }
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

        // Chuyển hướng tới trang chủ (HomeScreen) bằng GoRouter
        // ignore: use_build_context_synchronously
        context.push('/');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: Đăng xuất thất bại')),
      );
    }
  }

  Future<UserModel?> getUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final docSnapshot =
        await _firestore.collection('users').doc(user.uid).get();

    if (docSnapshot.exists) {
      return UserModel.fromMap(docSnapshot.data()!, user.uid);
    } else {
      return null;
    }
  }
}
