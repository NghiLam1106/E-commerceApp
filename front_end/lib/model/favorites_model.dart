import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesModel {
  final String? id;
  final String userId;
  final DocumentReference productRef;
  final String productId;
  final Timestamp timestamp;

  FavoritesModel({
    this.id,
    required this.userId,
    required this.productRef,
    required this.productId,
    required this.timestamp,
  });

  // Convert từ Firestore document
  factory FavoritesModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoritesModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      productRef: data['productRef'] ?? '',
      productId: data['productId'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  // Convert sang Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productRef': productRef,
      'productId': productId,
      'timestamp': timestamp,
    };
  }
}
