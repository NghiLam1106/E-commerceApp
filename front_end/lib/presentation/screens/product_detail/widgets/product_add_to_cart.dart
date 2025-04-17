import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/model/cart_model.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';
import 'package:go_router/go_router.dart';

class ProductAddToCart extends StatefulWidget {
  const ProductAddToCart(
      {super.key, required this.productId, required this.color});

  final String productId;
  final String color;

  @override
  State<ProductAddToCart> createState() => _ProductAddToCartState();
}

class _ProductAddToCartState extends State<ProductAddToCart> {
  // controller
  final CartController cartController = CartController();
  final ProductController productController = ProductController();

  int _quantity = 1;

  // hàm tăng số lượng
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  // hàm giảm số lượng
  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() async {
    final user = FirebaseAuth.instance.currentUser;
    // kiểm tra xem đã đang nhập hay chưa
    if (user != null) {
      // kiểm tra xem đã chọn màu hay chưa
      if (widget.color != '') {
        final productRef = productController.createRefProduct(widget.productId);
        final cartItem = CartModel(
          quantity: _quantity,
          color: widget.color,
          timestamp: Timestamp.now(),
          productRef: productRef,
        );

        // thêm vào csdl
        await cartController.addOrUpdateCartItem(cart: cartItem, userId: user.uid, productRef: productRef);

        // Thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã thêm $_quantity sản phẩm vào giỏ hàng')),
        );
      } else {
        // thông báo khi người dùng chưa chọn màu
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng chọn màu sắc cho sản phẩm')),
        );
      }
    } else {
      // điều hướng khi chưa đăng nhập
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
    }
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
