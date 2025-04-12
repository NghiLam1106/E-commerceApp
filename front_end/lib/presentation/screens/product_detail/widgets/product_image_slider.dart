import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({super.key, required this.imageList});

  final List<String> imageList;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  late String selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.imageList[0]; // Khởi tạo với ảnh đầu tiên
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Container(
      color: dark ? AppColors.darkerGrey : AppColors.lightGrey,
      child: Stack(
        children: [
          // Main large image
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(AppSizes.productImageRadius * 2),
              child: Center(
                child: Image(image: NetworkImage(selectedImage)),
              ),
            ),
          ),

          // image slider
          Positioned(
            right: 0,
            bottom: 20,
            left: AppSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(width: AppSizes.spaceBtwItems),
                  itemCount: widget.imageList.length,
                  itemBuilder: (_, index) {
                    final image = widget.imageList[index];
                    return RoundedImage(
                      isNetworkImage: true,
                      imageUrl: image,
                      width: 80,
                      border: Border.all(color: AppColors.primary),
                      padding: const EdgeInsets.all(AppSizes.sm),
                      onPressed: () {
                        setState(() {
                          selectedImage = image;
                        });
                      },
                    );
                  }),
            ),
          ),

          // Appbar
          AppbarCustom(
            showBackArrow: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, color: AppColors.darkerGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
