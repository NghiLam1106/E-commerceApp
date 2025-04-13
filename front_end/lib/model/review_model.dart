import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? id;
  final String username;
  final String avatarUrl;
  final String userId;
  final String review;
  final double rating;
  final String productId;
  final Timestamp timestamp;

  ReviewModel(
      {this.id,
      required this.username,
      required this.avatarUrl,
      required this.timestamp,
      required this.review,
      required this.rating,
      required this.userId,
      required this.productId});

  // Convert từ Firestore document
  factory ReviewModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      id: doc.id,
      username: data['username'] ?? '',
      avatarUrl: data['avatarUrl'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      review: data['review'] ?? '',
      rating: data['rating']?.toDouble() ?? 0.0,
      productId: data['productId'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  // Convert sang Map để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'avatarUrl': avatarUrl,
      'review': review,
      'rating': rating,
      'productId': productId,
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}
