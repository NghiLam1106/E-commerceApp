import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
  final String name;
  final String imageUrl;
  final Timestamp timestamp;

  CategoryModel({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.timestamp,
  });

  // Convert từ Firestore document
  factory CategoryModel.fromDocument(DocumentSnapshot doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception("Tài liệu không tồn tại hoặc không có dữ liệu.");
    }
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  // Convert sang Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }
}
