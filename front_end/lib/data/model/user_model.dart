class UserModel {
  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int,
        phoneNumber: json['phoneNumber'] as String,
        email: json['email'] as String?,
        fullName: json['fullName'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'email': email,
      'fullName': fullName,
    };
  }

  final int id;
  final String phoneNumber;
  final String? email;
  final String fullName;
}