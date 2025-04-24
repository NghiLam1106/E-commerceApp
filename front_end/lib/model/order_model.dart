import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final List<DocumentReference> cartRef;
  final DocumentReference addressRef;
  final String userId;
  final Timestamp? deleveryDate;
  final Timestamp? orderDate;

  OrderModel({
    this.id,
    required this.cartRef,
    required this.userId,
    this.deleveryDate,
    required this.addressRef,
    this.orderDate,
  });

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      cartRef: data['cartRef'],
      addressRef: data['addressRef'],
      userId: data['userId'] ?? '',
      deleveryDate: Timestamp.now(),
      orderDate: Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartRef': cartRef,
      'addressRef': addressRef,
      'userId': userId,
      'deleveryDate': deleveryDate,
      'orderDate': orderDate,
    };
  }
}
