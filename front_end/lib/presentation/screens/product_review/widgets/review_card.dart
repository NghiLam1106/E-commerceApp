import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/review_model.dart';
import 'package:front_end/presentation/screens/product_review/widgets/rating_bar_indicator.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      (review.avatarUrl.isNotEmpty)
                          ? NetworkImage(review.avatarUrl)
                          : AssetImage(AppImages.google) as ImageProvider,
                  radius: 20,
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Text(review.username,
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),

        const SizedBox(width: AppSizes.spaceBtwItems),
        //Review
        Row(
          children: [
            AppRatingBarIndicator(
              rating: review.rating,
            ),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(review.timestamp.toDate().toString(),
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        ReadMoreText(
          review.review,
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          lessStyle: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
              fontWeight: FontWeight.bold),
          moreStyle: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: AppSizes.spaceBtwSections),
      ],
    );
  }
}
