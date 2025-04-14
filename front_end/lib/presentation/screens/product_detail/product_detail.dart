import 'package:flutter/material.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/product_add_to_cart.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/product_image_slider.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/product_meta_data.dart';
import 'package:front_end/presentation/screens/product_detail/widgets/rating_and_share.dart';
import 'package:front_end/presentation/widgets/chips/choice_chip.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // Controllers
  final ProductController productController = ProductController();
  late ProductModel _productData;
  bool _isLoading = true;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final products = await productController.getProductById(id: widget.productId);
    setState(() {
      _productData = products;
      _isLoading = false;
    });
  }

  int? _selectedColorIndex; // Thay vì dùng String?

  void _onColorSelected(int index) {
    setState(() {
      _selectedColorIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      bottomSheet: const ProductAddToCart(),
      body: Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Product image slider
              ProductImageSlider(
                imageList: _productData.imageUrls,
              ),

              // Product detail
              Padding(
                padding: const EdgeInsets.only(
                    right: AppSizes.defaultSpace, left: AppSizes.defaultSpace),
                child: Column(
                  children: [
                    // Rating and share button
                    const RatingAndShare(), // chờ xong review screen mới update lại

                    // Price, title, stock, brand
                    ProductMetaData(
                        title: _productData.name, price: _productData.price, brandId: _productData.brandId,),

                    // Colors
                    Column(
                      children: [
                        AppSectionHeading(title: 'Màu sắc',showActionButton: false,),
                        SizedBox(height: AppSizes.spaceBtwItems / 2),
                        Wrap(
                          spacing: AppSizes.spaceBtwItems,
                          children: [
                            if (_productData.colors.isEmpty)
                              SizedBox(height: AppSizes.spaceBtwItems / 2)
                            else
                              ..._productData.colors
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final color = entry.value;
                                return CustomChoiceChip(
                                  text: color,
                                  isSelected: _selectedColorIndex == index,
                                  onSelected: (_) => _onColorSelected(index),
                                );
                              })
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    // Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Thanh toán'),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // Description
                    ReadMoreText(
                      _productData.description,
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
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    AppSectionHeading(
                      title: 'Reviews(12)',
                      onPressed: (){
                        context.push('/review/${_productData.id}');
                      },
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
