import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/calculate_avg_ratings.dart';
import 'package:front_end/model/review_model.dart';

class RatingAndShare extends StatelessWidget {
  const RatingAndShare({
    super.key, required this.reviewlist,
  });

  final List<ReviewModel> reviewlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          
          children: [
            Icon(Icons.star, color: Colors.amber, size: 24),
            const SizedBox(width: AppSizes.spaceBtwItems / 2),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: calculateAvgRatings(reviews: reviewlist).toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(
                  text: '(${reviewlist.length.toString()})', 
                  style: TextStyle(color: AppColors.grey))
            ]))
          ],
        ),
    
        // Share button
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.share, color: AppColors.primary))
      ],
    );
  }
}
