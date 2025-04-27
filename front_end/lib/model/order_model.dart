import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final List<DocumentReference> cartRef;
  final DocumentReference addressRef;
  final String userId;
  final Timestamp? deliveryDate;
  final Timestamp? orderDate;

  OrderModel({
    this.id,
    required this.cartRef,
    required this.userId,
    this.deliveryDate,
    required this.addressRef,
    this.orderDate,
  });

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      cartRef: (data['cartRef'] as List<dynamic>).map((e) => e as DocumentReference<Object?>).toList(),
      addressRef: data['addressRef'] as DocumentReference<Object?>,
      userId: data['userId'] ?? '',
      deliveryDate: data['deliveryDate'],
      orderDate: data['orderDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartRef': cartRef,
      'addressRef': addressRef,
      'userId': userId,
      'deliveryDate': deliveryDate,
      'orderDate': orderDate,
    };
  }
}
