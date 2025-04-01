import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/product_review/widgets/rating_bar_indicator.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(AppImages.google)),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),

        const SizedBox(width: AppSizes.spaceBtwItems),
        //Rview
        Row(
          children: [
            const AppRatingBarIndicator(
              rating: 4.5,
            ),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text('thoi gian', style: Theme.of(context).textTheme.bodyMedium),

          ],
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        ReadMoreText(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consequat nibh. Etiam non elit dui. Nulla nec purus feugiat, molestie ipsum et, consequat nibh. Etiam non elit dui.',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          lessStyle: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.bold),
          moreStyle: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: AppSizes.spaceBtwSections),
      ],
    );
  }
}
