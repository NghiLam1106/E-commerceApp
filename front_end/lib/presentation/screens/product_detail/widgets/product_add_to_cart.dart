import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';

class ProductAddToCart extends StatefulWidget {
  const ProductAddToCart({super.key});

  @override
  State<ProductAddToCart> createState() => _ProductAddToCartState();
}

class _ProductAddToCartState extends State<ProductAddToCart> {
  int _quantity = 1; // Sử dụng int thay vì String để dễ xử lý

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    // Xử lý thêm vào giỏ hàng với số lượng _quantity
    debugPrint('Thêm vào giỏ hàng: $_quantity sản phẩm');
    // Có thể thêm SnackBar thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thêm $_quantity sản phẩm vào giỏ hàng')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace, 
        vertical: AppSizes.defaultSpace,
      ),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadiusLg),
          topRight: Radius.circular(AppSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Nút giảm số lượng
              CircularIcon(
                onPressed: _decrementQuantity,
                icon: Icons.remove,
                backgroundColor: AppColors.darkgrey,
                width: 40,
                height: 40,
                color: AppColors.white,
              ),

              // Hiển thị số lượng
              const SizedBox(width: AppSizes.spaceBtwItems),
              Text(
                '$_quantity', 
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // Nút tăng số lượng
              const SizedBox(width: AppSizes.spaceBtwItems),
              CircularIcon(
                onPressed: _incrementQuantity,
                icon: Icons.add,
                backgroundColor: AppColors.black,
                width: 40,
                height: 40,
                color: AppColors.white,
              ),
            ],
          ),
          
          // Nút thêm vào giỏ hàng
          ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(AppSizes.md),
              backgroundColor: AppColors.black,
              side: const BorderSide(color: AppColors.black),
            ),
            child: const Text('Thêm vào giỏ hàng'),
          ),
        ],
      ),
    );
  }
}