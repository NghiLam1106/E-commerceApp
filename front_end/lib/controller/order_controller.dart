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



Future<Map<DateTime, int>> getOrderCountLast7Days() async {
  final now = DateTime.now();
  final sevenDaysAgo = now.subtract(Duration(days: 6)); // Tính từ 6 ngày trước + hôm nay = 7 ngày

  final snapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('orderDate', isGreaterThanOrEqualTo: Timestamp.fromDate(
        DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day),
      ))
      .orderBy('orderDate')
      .get();

  Map<DateTime, int> ordersPerDay = {};

  for (var doc in snapshot.docs) {
    Timestamp timestamp = doc['orderDate'];
    DateTime orderDate = timestamp.toDate();
    DateTime dayOnly = DateTime(orderDate.year, orderDate.month, orderDate.day);

    ordersPerDay[dayOnly] = (ordersPerDay[dayOnly] ?? 0) + 1;
  }

  // Đảm bảo tất cả 7 ngày đều có giá trị (dù 0 đơn cũng có)
  for (int i = 0; i < 7; i++) {
    final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
    ordersPerDay.putIfAbsent(date, () => 0);
  }

  return ordersPerDay;
}


}
