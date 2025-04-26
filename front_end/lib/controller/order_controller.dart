import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/order_model.dart';

class OrderController {
  // Get collection
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  // create
  Future<void> addOrder(OrderModel order) {
    return orders.add(order.toMap());
  }

  Future<OrderModel> getOrderById(String orderId) async {
    final snapshot = await orders.doc(orderId).get();

    return OrderModel.fromDocument(snapshot);
  }

    Future<List<OrderModel>> getOrderByIdUser(String id) async {
    final snapshot = await orders.where('userId', isEqualTo: id)
          .orderBy('orderDate', descending: true)
          .get();

    return snapshot.docs.map((doc) => OrderModel.fromDocument(doc)).toList();
  }
}
