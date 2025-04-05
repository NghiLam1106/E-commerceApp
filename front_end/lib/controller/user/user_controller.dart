import 'package:cloud_firestore/cloud_firestore.dart';

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
}
