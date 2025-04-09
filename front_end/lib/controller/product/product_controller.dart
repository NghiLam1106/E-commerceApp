import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/product_model.dart';

class ProductController {

  // Get collection
  final CollectionReference products = FirebaseFirestore.instance.collection('products');
  
  // create
 Future<void> addProduct(ProductModel product) {
    return products.add(product.toMap());
  }


  // update
  Future<void> updateProduct(ProductModel product) {
    return products.doc(product.id).update(product.toMap());
  }

  // delete
  Future<void> removeProduct(String id) {
    return products.doc(id).delete();
  }
  Stream<QuerySnapshot> getProducts({String? name, bool? isPriceDescending}) {
  Query query = products;

  // Tìm kiếm theo tên nếu có nhập
  if (name != null && name.isNotEmpty) {
    query = query
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: name + 'z');
    return query.snapshots();
  }

  // Sắp xếp theo giá nếu có yêu cầu
  if (isPriceDescending != null) {
    query = query.orderBy('price', descending: isPriceDescending);
  } else {
    // Mặc định sắp xếp theo thời gian thêm mới nhất
    query = query.orderBy('timestamp', descending: true);
  }

  return query.snapshots();
}
}