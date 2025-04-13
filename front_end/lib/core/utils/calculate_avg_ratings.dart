import 'package:front_end/model/review_model.dart';

  double calculateAvgRatings({required List<ReviewModel> reviews}) {
    if (reviews.isEmpty) return 0.0;
    final total = reviews.fold(0.0, (sum, item) => sum + item.rating);
    return total / reviews.length;
  }