import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_end/model/review_model.dart';

class ReviewController {
  // Collection
  final CollectionReference reviews =
      FirebaseFirestore.instance.collection('reviews');

  // Create review
  Future<void> addReview(ReviewModel review) {
    return reviews.add(review.toMap());
  }

  // Update review
  Future<void> updateReview(ReviewModel review) {
    if (review.id == null) {
      throw Exception('Review ID is null');
    }

    return reviews.doc(review.id).update({
      'username': review.username,
      'avatarUrl': review.avatarUrl,
      'review': review.review,
      'rating': review.rating,
      'productId': review.productId,
      'timestamp': review.timestamp,
      'userId': review.userId,
    });
  }

  // Delete review
  Future<void> deleteReview(String id) {
    return reviews.doc(id).delete();
  }

  // Get reviews for a specific product
  Future<List<ReviewModel>> getReviewsForProduct(String productId) async {
    final query = await reviews
        .where('productId', isEqualTo: productId)
        .orderBy('timestamp', descending: true)
        .get();

    return query.docs.map((doc) => ReviewModel.fromDocument(doc)).toList();
  }
}
