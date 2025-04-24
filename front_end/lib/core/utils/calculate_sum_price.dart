import 'package:front_end/model/cart_model.dart';
import 'package:front_end/model/product_model.dart';

Future<String> calculateSumPrice({required List<CartModel> cartList}) async {
  double sum = 0.0;
  for (final cart in cartList) {
    final quantity = cart.quantity;
    final ref = cart.productRef;

    if (ref != null) {
      final productSnapshot = await ref.get();
      final product = ProductModel.fromSnapshot(productSnapshot);
      final price = double.parse(product.price);
      sum += price * quantity;
    }
  }
  return sum.toString();
}




