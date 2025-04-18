import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String? id; // ID của địa chỉ
  final String name;
  final String phoneNumber;
  final String address;
  final String uid;
  final String status;

  AddressModel({
    this.id,
    this.uid = '',
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.status = '',
  });

  // Chuyển đổi từ Map (Firestore) thành đối tượng AddressModel
  factory AddressModel.fromSnapshot(DocumentSnapshot doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception("Tài liệu không tồn tại hoặc không có dữ liệu.");
    }
    final data = doc.data() as Map<String, dynamic>;
    return AddressModel(
      id: doc.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      status: data['status'] ?? '',
    );
  }

  // Chuyển đổi đối tượng AddressModel thành Map (lưu vào Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'uid': uid,
      'status': status,
      'createdAt': DateTime.now(),
    };
  }
}
