import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:front_end/controller/auth/auth_controller.dart';
import 'package:front_end/controller/review_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/calculate_avg_ratings.dart';
import 'package:front_end/model/review_model.dart';
import 'package:front_end/model/user_model.dart';
import 'package:front_end/presentation/screens/product_review/widgets/overall_product_rating.dart';
import 'package:front_end/presentation/screens/product_review/widgets/review_card.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:go_router/go_router.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();

  final ReviewController reviewController = ReviewController();

  double _userRating = 0.0;
  UserModel? _userData;
  List<ReviewModel> _reviews = [];

  @override
  void initState() {
    super.initState();
    _getData();
    _getReviews();
  }

  void _getData() async {
    final auth = AuthController();
    final user = await auth.getUserData();

    if (user != null) {
      setState(() {
        _userData = user;
      });
    }
  }

  void _getReviews() async {
    final reviews = await reviewController.getReviewsForProduct(widget.productId);
    setState(() {
      _reviews = reviews;
    });
  }

  void _handleSendReview() async {
    if (_userData == null) {
      context.go('/login');
      return;
    }

    if (_reviewController.text.isEmpty || _userRating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    final newReview = ReviewModel(
      review: _reviewController.text,
      rating: _userRating,
      productId: widget.productId,
      userId: _userData!.uid,
      username: _userData!.name,
      avatarUrl: _userData!.avatar,
      timestamp: Timestamp.now(),
    );

    await reviewController.addReview(newReview);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đánh giá đã được gửi')),
    );

    setState(() {
      _reviewController.clear();
      _userRating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppbarCustom(title: Text('Reviews and Ratings'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Overall rating
              OverallProductRating(avgRating: calculateAvgRatings(reviews: _reviews), reviews: _reviews,),
              const SizedBox(height: AppSizes.spaceBtwSections),
              const Divider(thickness: 1),

              // Review list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  return ReviewCard(review: _reviews[index]);
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.sm),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _userRating = rating;
                });
              },
            ),
            TextFormField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Write a review',
                suffixIcon: IconButton(
                  onPressed: () {
                    _handleSendReview();
                  },
                  icon: Icon(Icons.send, color: AppColors.primary),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
