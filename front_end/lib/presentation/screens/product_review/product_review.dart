import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/product_review/widgets/overall_product_rating.dart';
import 'package:front_end/presentation/screens/product_review/widgets/rating_bar_indicator.dart';
import 'package:front_end/presentation/screens/product_review/widgets/review_card.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';

class ProductReviewSreen extends StatelessWidget {
  const ProductReviewSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: Text('Reviews and Ratings'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(AppSizes.defaultSpace),child: Column(
          children: [
            // Overall rating
            const OverallProductRating(),
            AppRatingBarIndicator(rating: 4.5,),
            Text('11,45', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: AppSizes.spaceBtwSections), // 32

            // Review list
            const ReviewCard(),
            const ReviewCard(),
          ],
        ),),
      ),
      bottomSheet: TextFormField(
        decoration: InputDecoration(
          hintText: 'Write a review',
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.send, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

