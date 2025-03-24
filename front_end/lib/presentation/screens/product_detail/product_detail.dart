import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/product_add_to_cart.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/product_image_slider.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/product_meta_data.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/rating_and_share.dart';
import 'package:front_end/presentation/widgets/chips/choice_chip.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: ProductAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product image slider
            ProductImageSlider(),

            // Product detail
            Padding(
              padding: EdgeInsets.only(
                  right: AppSizes.defaultSpace, left: AppSizes.defaultSpace),
              child: Column(
                children: [
                  // Rating and share button
                  RatingAndShare(),

                  // Price, title, stock, brand
                  ProductMetaData(),

                  // Colors
                  const Column(
                    children: [
                      AppSectionHeading(title: 'Colors'),
                      SizedBox(height: AppSizes.spaceBtwItems / 2), //8
                      Wrap(
                        children: [
                          CustomChoiceChip(text: 'Green', isSelected: false),
                          CustomChoiceChip(text: 'Red', isSelected: true),
                          CustomChoiceChip(text: 'Blue', isSelected: false),
                        ],
                      )
                    ],
                  ),

                  // Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Checkout')),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems), // 16

                  // Description
                  const ReadMoreText(
                    'gio thieu san pham lay tu api',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  // Review
                  const Divider(),
                  const SizedBox(height: AppSizes.spaceBtwItems), // 16
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppSectionHeading(
                        title: 'Reviews(12)',
                        showActionButton: true,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections), // 32    
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
