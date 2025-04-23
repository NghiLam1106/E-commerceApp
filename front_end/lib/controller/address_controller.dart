import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/address_model.dart';

class AddressController {
  // Get collection
  final CollectionReference address =
      FirebaseFirestore.instance.collection('address');

  // Thêm
  Future<void> addAddress(AddressModel addressModel) {
    return address.add(addressModel.toMap());
  }

  // Lấy thông tin theo ID người dùng
  Future<List<AddressModel>> getAddressByUserId(String userId) async {
    final snapshot = await address.where('uid', isEqualTo: userId).get();
    return snapshot.docs.map((doc) => AddressModel.fromSnapshot(doc)).toList();
  }

  // Phương thức cập nhật status của địa chỉ
  Future<void> updateAddressStatus(String addressId, String newStatus) async {
    try {
      await address.doc(addressId).update({
        'status': newStatus,
      });
    } catch (e) {
      throw Exception('Không thể cập nhật status: $e');
    }
  }

  // Lấy ID của Address theo ID người dùng
  Future<List<String>> getAddressIdsByUserId(String userId) async {
    try {
      final snapshot = await address.where('uid', isEqualTo: userId).get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => doc.id)
            .toList(); // Collect all document IDs
      }
    } catch (e) {
      throw Exception('Không thể lấy danh sách ID địa chỉ: $e');
    }
    return []; // Return an empty list if no addresses are found
  }

  Stream<List<AddressModel>> getAddressIdsByUserIdStream(String userId) {
    return address
        .where('uid', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AddressModel.fromSnapshot(doc))
            .toList());
  }

  DocumentReference createRefAddress(String id) {
    return address.doc(id);
  }
}
