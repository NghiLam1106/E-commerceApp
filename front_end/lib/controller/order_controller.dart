import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/order_model.dart';

class OrderController {
  // Get collection
  final CollectionReference catogories =
      FirebaseFirestore.instance.collection('orders');

  // create
  Future<void> addOrder(OrderModel order) {
    return catogories.add(order.toMap());
  }

  Stream<QuerySnapshot> getcategories({String? name, bool? isPriceDescending}) {
    Query query = catogories;

    // Tìm kiếm theo tên nếu có nhập
    if (name != null && name.isNotEmpty) {
      query = query
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThan: name + 'z');
      return query.snapshots();
    }

    // Sắp xếp theo giá nếu có yêu cầu
    if (isPriceDescending != null) {
      query = query.orderBy('timestamp', descending: isPriceDescending);
    }
    return query.snapshots();
  }

  Future<List<OrderModel>> getCategories() async {
    final snapshot =
        await catogories.orderBy('timestamp', descending: false).get();
    return snapshot.docs.map((doc) => OrderModel.fromDocument(doc)).toList();
  }

  Future<OrderModel> getOrderById(String id) async {
    final snapshot = await catogories.doc(id).get();

    return OrderModel.fromDocument(snapshot);
  }

    Future<List<OrderModel>> getOrderByIdUser(String id) async {
    final snapshot = await catogories.where('userId', isEqualTo: id)
          .orderBy('orderDate', descending: true)
          .get();

    return snapshot.docs.map((doc) => OrderModel.fromDocument(doc)).toList();
  }
}
