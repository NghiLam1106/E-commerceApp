import 'package:flutter/material.dart';
import 'package:front_end/model/review_model.dart';
import 'package:front_end/presentation/screens/product_review/widgets/rating_bar_indicator.dart';
import 'package:front_end/presentation/screens/product_review/widgets/rating_progress_indicator.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
    required this.avgRating,
    required this.reviews,
  });

  final double avgRating;
  final List<ReviewModel> reviews;

  // Tính toán phân phối đánh giá
  // Phân phối đánh giá là tỷ lệ phần trăm của mỗi đánh giá (1-5) trong tổng số đánh giá
  Map<int, double> _calculateRatingDistribution() {
    final distribution = <int, int>{
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0
    }; // Khởi tạo một map distribution để đếm số lượt đánh giá từ 1 đến 5
    // Duyệt qua từng đánh giá và tăng số lượng tương ứng trong distribution
    for (var review in reviews) {
      // Sử dụng round() để làm tròn đánh giá về số nguyên gần nhất
      // Và clamp để đảm bảo giá trị nằm trong khoảng từ 1 đến 5
      final roundedRating = review.rating.round().clamp(1, 5);
      // Sau đó tăng số lượt đánh giá tương ứng trong distribution
      distribution[roundedRating] = distribution[roundedRating]! + 1;
    }

    final total = reviews.length.toDouble();
    // Tính toán tỷ lệ phần trăm cho mỗi đánh giá
    return distribution.map((key, value) {
      return MapEntry(key, total == 0 ? 0 : value / total);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ratingDistribution = _calculateRatingDistribution();
    return Row(children: [
      Expanded(
          flex: 3,
          child: Column(children: [
            Text(avgRating.toStringAsFixed(1),
                style: Theme.of(context).textTheme.displayLarge),
            AppRatingBarIndicator(rating: avgRating),
            Text(reviews.length.toString(),
                  style: Theme.of(context).textTheme.bodySmall),
          ])),
      Expanded(
          flex: 7,
          child: Column(
            children: List.generate(5, (index) {
              final star = 5 - index; // Hiển thị từ 5 → 1
              return RatingProgressIndicator(
                text: star.toString(),
                value: ratingDistribution[star] ?? 0,
              );
            }),
          ))
    ]);
  }
}
