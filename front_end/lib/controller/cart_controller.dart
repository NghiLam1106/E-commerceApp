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

  Future<void> clearUserCart(String userId) async {
    final cartCollection = getUserCartCollection(userId);
    final snapshot = await cartCollection.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
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
        .where('paid', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CartModel.fromDocument(doc)).toList());
  }

  Future<List<CartModel>> getUserCartFuture(String userId) async {
    final snapshot = await getUserCartCollection(userId)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs.map((doc) => CartModel.fromDocument(doc)).toList();
  }

  Future<void> addOrUpdateCartItem({
    required String userId,
    required DocumentReference productRef,
    required CartModel cart,
  }) async {
    final cartItemQuery = await getUserCartCollection(userId)
        .where('productRef', isEqualTo: productRef)
        .where('paid',
            isEqualTo: false) // Chỉ thao tác với giỏ hàng chưa thanh toán
        .limit(1)
        .get();

    if (cartItemQuery.docs.isNotEmpty) {
      // Sản phẩm đã có trong giỏ chưa thanh toán
      final doc = cartItemQuery.docs.first;
      final currentQty = doc['quantity'] ?? 1;

      await doc.reference.update({
        'quantity': currentQty + 1,
        'timestamp': Timestamp.now(),
      });
    } else {
      // Sản phẩm chưa có trong giỏ -> thêm mới
      final newCart = cart.toMap();

      await getUserCartCollection(userId).add(newCart);
    }
  }

  DocumentReference createRefCart(String cartId, String userId) {
    return getUserCartCollection(userId).doc(cartId);
  }

  Future<void> markCartsAsPaid({
    required String userId,
    required List<CartModel> cartList,
  }) async {
    final batch = FirebaseFirestore.instance.batch();

    for (final cart in cartList) {
      if (cart.id == null) continue;

      final cartRef = getUserCartCollection(userId).doc(cart.id);

      batch.update(cartRef, {
        'paid': true,
        'timestamp': Timestamp.now(), // nếu muốn cập nhật luôn thời gian
      });
    }

    await batch.commit();
  }

  Future<CartModel> getCartFromRef(DocumentReference ref) async {
    final snapshot = await ref.get();
    return CartModel.fromDocument(snapshot);
  }
}
