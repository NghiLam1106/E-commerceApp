import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';

class RatingAndShare extends StatelessWidget {
  const RatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          
          children: [
            Icon(Icons.star, color: AppColors.primary, size: 24),
            const SizedBox(width: AppSizes.spaceBtwItems / 2),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '4.5',
                  style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(
                  text: '(200)',
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
