import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/product_model.dart';

class ProductController {
  // Get collection
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

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

  // Get list of products limit 6
  Future<List<ProductModel>> getProductsListLimit() async {
    final snapshot =
        await products.orderBy('timestamp', descending: true).limit(6).get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  Future<List<ProductModel>> getProductsList() async {
    final snapshot =
        await products.orderBy('timestamp', descending: true).limit(6).get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  Future<ProductModel> getProductById({required String id}) async {
    final snapshot = await products.doc(id).get();

    return ProductModel.fromSnapshot(snapshot);
  }

  Future<List<ProductModel>> getProductsByCategory(
      {required String categoryId}) async {
    final snapshot =
        await products.where('categoryId', isEqualTo: categoryId).get();

    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  Stream<QuerySnapshot> getProducts({String? name, bool? isPriceDescending}) {
    Query query = products;

    if (name != null && name.isNotEmpty) {
      query = query
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThan: name + 'z');
      return query.snapshots();
    }

    if (isPriceDescending != null) {
      query = query.orderBy('price', descending: isPriceDescending);
    } else {
      query = query.orderBy('timestamp', descending: true);
    }

    return query.snapshots();
  }


Stream<ProductModel> streamProductFromRef(DocumentReference ref) {
  return ref.snapshots().map((snapshot) =>
      ProductModel.fromSnapshot(snapshot));
}


  DocumentReference createRefProduct(String id) {
    return products.doc(id);
  }
}
