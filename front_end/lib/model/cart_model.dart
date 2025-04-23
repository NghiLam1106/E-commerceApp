import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String? id;
  final DocumentReference? productRef;
  late final int quantity;
  final String color;
  final bool paid;
  final Timestamp timestamp;

  CartModel({
    this.id,
    this.productRef,
    required this.quantity,
    required this.color,
    required this.paid,    
    required this.timestamp,
  });

  factory CartModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: doc.id,
      productRef: data['productRef'],
      quantity: data['quantity'] ?? 1,
      color: data['color'] ?? '', 
      paid: data['paid'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productRef': productRef,
      'quantity': quantity,
      'color': color,
      'paid': paid,
      'timestamp': timestamp,
    };
  }
}
