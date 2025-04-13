import 'package:front_end/controller/brand_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/enums.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/image/circular_image.dart';
import 'package:front_end/presentation/widgets/texts/brand_title_and_verify_icon.dart';
import 'package:front_end/presentation/widgets/texts/product_price_text.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatefulWidget {
  const ProductMetaData({
    super.key,
    required this.price,
    required this.title,
    required this.brandId,
  });

  final String price;
  final String title;
  final String brandId;

  @override
  State<ProductMetaData> createState() => _ProductMetaDataState();
}

class _ProductMetaDataState extends State<ProductMetaData> {
  String? brandName;
  String? brandImageUrl;

  final BrandController brandController = BrandController();

  @override
  void initState() {
    super.initState();
    _loadBrandData();
  }

  Future<void> _loadBrandData() async {
    final brand = await brandController.getBrandById(widget.brandId);
    if (mounted) {
      setState(() {
        brandName = brand.name;
        brandImageUrl = brand.imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductPriceText(price: widget.price, isLarge: true),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

        brandName == null
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  CircularImages(
                    isNetworkImage: true,
                    image: brandImageUrl ?? AppImages.google,
                    width: 40,
                    height: 40,
                    overlayColor: dark ? AppColors.white : AppColors.black,
                  ),
                  BrandTitleAndVerifyIcon(
                    title: brandName!,
                    brandTextSize: TextSizes.medium,
                  ),
                ],
              )
      ],
    );
  }
}