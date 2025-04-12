import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  final String? id;
  final String name;
  final String imageUrl;
  final Timestamp timestamp;

  BrandModel({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.timestamp,
  });

  // Convert từ Firestore document
  factory BrandModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BrandModel(
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
