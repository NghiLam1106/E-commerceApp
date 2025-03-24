import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:front_end/core/constants/colors.dart';

class AppRatingBarIndicator extends StatelessWidget {
  const AppRatingBarIndicator({
    super.key, required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: AppColors.primary,
      ),
      unratedColor: AppColors.grey,
      itemCount: 5,
      itemSize: 20.0,
    );
  }
}

