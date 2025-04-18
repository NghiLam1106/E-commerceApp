import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/favorites_model.dart';

class FavoritesController {
  // Get collection
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  // create
  Future<void> addFavorites(FavoritesModel favorite) {
    return favorites.add(favorite.toMap());
  }

  // delete
  Future<void> removeFavorites(String id) {
    return favorites.doc(id).delete();
  }

  // danh sách yêu thích theo userId
  Future<List<FavoritesModel>> getFavoritesForProduct(String userId) async {
    final query = await favorites
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return query.docs.map((doc) => FavoritesModel.fromDocument(doc)).toList();
  }
}
