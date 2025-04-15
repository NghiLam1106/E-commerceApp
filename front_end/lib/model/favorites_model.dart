import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesModel {
  final String? id;
  final String userId;
  final String productId;
  final String nameProduct;
  final String imageUrlProduct;
  final String brandId;
  final String priceProduct;
  final Timestamp timestamp;

  FavoritesModel({
    this.id,
    required this.userId,
    required this.productId,
    required this.brandId,
    required this.nameProduct,
    required this.imageUrlProduct,
    required this.priceProduct,
    required this.timestamp,
  });

  // Convert từ Firestore document
  factory FavoritesModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoritesModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      productId: data['productId'] ?? '',
      nameProduct: data['nameProduct'] ?? '',
      brandId: data['brandId'] ?? '',
      imageUrlProduct: data['imageUrlProduct'] ?? '',
      priceProduct: data['priceProduct'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  // Convert sang Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'nameProduct': nameProduct,
      'brandId': brandId,
      'imageUrlProduct': imageUrlProduct,
      'priceProduct': priceProduct,
      'timestamp': timestamp,
    };
  }
}
