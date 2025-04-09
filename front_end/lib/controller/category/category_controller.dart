import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/categories_model.dart';

class CategoryController {
  // Get collection
  final CollectionReference catogories =
      FirebaseFirestore.instance.collection('catogories');

  // create
  Future<void> addCategory(String name, String imageURL) {
    return catogories.add({
      'name': name,
      'imageUrl': imageURL,
      'timestamp': Timestamp.now(),
    });
  }

  // update
  Future<void> updateProduct(String id, String name, String imageURL) {
    return catogories.doc(id).update({
      'name': name,
      'imageUrl': imageURL,
    });
  }

  // delete
  Future<void> removeProduct(String id) {
    return catogories.doc(id).delete();
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

Future<List<CategoryModel>> getCategories() async {
  final snapshot = await catogories.orderBy('timestamp', descending: true).get();
  return snapshot.docs.map((doc) => CategoryModel.fromDocument(doc)).toList();
}


  Future<CategoryModel> getCategoryById(String id) async {
    final snapshot = await catogories.doc(id).get();

    return CategoryModel.fromDocument(snapshot);
  }
}
