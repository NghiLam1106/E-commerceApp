import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String? id;
  final DocumentReference? productRef;
  late final int quantity;
  final String color;
  final Timestamp timestamp;

  CartModel({
    this.id,
    this.productRef,
    required this.quantity,
    required this.color,
    required this.timestamp,
  });

  factory CartModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: doc.id,
      productRef: data['productRef'],
      quantity: data['quantity'] ?? 1,
      color: data['color'] ?? '',      
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productRef': productRef,
      'quantity': quantity,
      'color': color,
      'timestamp': timestamp,
    };
  }
}
