import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final DocumentReference? productRef;
  late final int quantity;
  final String color;
  final String userId;
  final Timestamp timestamp;

  OrderModel({
    this.id,
    this.productRef,
    required this.quantity,
    required this.color,
    required this.userId,
    required this.timestamp,
  });

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      productRef: data['productRef'],
      quantity: data['quantity'] ?? 1,
      color: data['color'] ?? '',  
      userId: data['userId'] ?? '',    
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productRef': productRef,
      'quantity': quantity,
      'color': color,
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}
