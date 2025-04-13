import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/brand_model.dart';

class BrandController {
  // Get collection
  final CollectionReference catogories =
      FirebaseFirestore.instance.collection('brands');

  // create
  Future<void> addBrand(String name, String imageURL) {
    return catogories.add({
      'name': name,
      'imageUrl': imageURL,
      'timestamp': Timestamp.now(),
    });
  }

  // update
  Future<void> updateBrand(String id, String name, String imageURL) {
    return catogories.doc(id).update({
      'name': name,
      'imageUrl': imageURL,
    });
  }

  // delete
  Future<void> removeBrand(String id) {
    return catogories.doc(id).delete();
  }

  Stream<QuerySnapshot> getBrandsList({String? name, bool? isPriceDescending}) {
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

  Future<List<BrandModel>> getBrands() async {
    final snapshot =
        await catogories.orderBy('timestamp', descending: true).limit(4).get();
    return snapshot.docs.map((doc) => BrandModel.fromDocument(doc)).toList();
  }

  Future<BrandModel> getBrandById(String id) async {
    final snapshot = await catogories.doc(id).get();

    return BrandModel.fromDocument(snapshot);
  }
}
