class UserModel {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;
  final String address;
  final String role;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
    required this.phoneNumber,
    required this.address,
    required this.role,
  });

  // Chuyển đổi từ Map (Firestore) thành đối tượng UserModel
  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      uid: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      avatar: data['avatar'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      role: data['role'] ?? 'user',
    );
  }

  // Chuyển đổi đối tượng UserModel thành Map (lưu vào Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'address': address,
      'role': role,
      'createdAt': DateTime.now(),
    };
  }
}
