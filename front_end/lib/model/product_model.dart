import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id;
  final String name;
  final String price;
  final String categoryId;
  final List<String> imageUrls;
  final String description;
  final String brandId;
  final List<String> colors;
  final Timestamp? timestamp;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.imageUrls,
    required this.description,
    required this.brandId,
    required this.colors,
    this.timestamp,
  });

  // Convert từ Firestore document
  factory ProductModel.fromSnapshot(DocumentSnapshot doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception("Tài liệu không tồn tại hoặc không có dữ liệu.");
    }
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      categoryId: data['categoryId'] ?? '',
      price: data['price'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      description: data['description'] ?? '',
      brandId: data['brandId'] ?? '',
      colors: List<String>.from(data['colors'] ?? []),
      timestamp: Timestamp.now(),
    );
  }

  // Convert sang Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'price': price,
      'imageUrls': imageUrls,
      'description': description,
      'brandId': brandId,
      'colors': colors,
      'timestamp': timestamp,
    };
  }
}
