import 'package:flutter/material.dart';
import 'package:front_end/presentation/screens/product_review/widgets/rating_progress_indicator.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text('4.5', style: Theme.of(context).textTheme.displayLarge)),
        Expanded(flex: 7, child: Column(
          children: [
            RatingProgressIndicator(text: '5', value: 0.3,),
            RatingProgressIndicator(text: '4', value: 0.7,),
            RatingProgressIndicator(text: '3', value: 0.5,),
            RatingProgressIndicator(text: '2', value: 0.9,),
            RatingProgressIndicator(text: '1', value: 0.4,),
          ],
        ))
      ]
    );
  }
}

