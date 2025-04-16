import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/cart_model.dart';

class CartController {
  // Collection
  CollectionReference getUserCartCollection(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');
  }

  // Create cart
  Future<void> addcart(CartModel cart, String userId) {
    return getUserCartCollection(userId).add(cart.toMap());
  }

  // Delete cart
  Future<void> deletecart(String id, String userId) {
    return getUserCartCollection(userId).doc(id).delete();
  }

  Future<void> updateQuantity(
      String userId, String cartItemId, int newQuantity) {
    return getUserCartCollection(userId).doc(cartItemId).update({
      'quantity': newQuantity,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<List<CartModel>> getUserCart(String userId) {
    return getUserCartCollection(userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CartModel.fromDocument(doc)).toList());
  }

  Future<void> addOrUpdateCartItem({
    required String userId,
    required DocumentReference productRef,
    required CartModel cart,
  }) async {
    // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
    final cartItemQuery = await getUserCartCollection(userId)
        .where('productRef', isEqualTo: productRef)
        .limit(1)
        .get();

    if (cartItemQuery.docs.isNotEmpty) {
      // Nếu sản phẩm đã có trong giỏ, tăng số lượng
      final doc = cartItemQuery.docs.first;
      final currentQty = doc['quantity'] ?? 1;

      // Cập nhật số lượng sản phẩm trong giỏ
      await doc.reference.update({
        'quantity': currentQty + 1,
        'timestamp': Timestamp.now(), // Cập nhật thời gian
      });
    } else {
      // Nếu sản phẩm chưa có trong giỏ, thêm mới vào giỏ hàng
      await getUserCartCollection(userId).add(cart.toMap());
    }
  }
}
