import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/model/cart_model.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';
import 'package:front_end/presentation/widgets/product/cart/cart_item.dart';
import 'package:front_end/presentation/widgets/texts/product_price_text.dart';
import 'package:go_router/go_router.dart';

class CartItems extends StatefulWidget {
  const CartItems({
    super.key,
    this.showAddRemoveBtn = true,
  });

  final bool showAddRemoveBtn;

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  // controller
  final CartController cartController = CartController();
  final ProductController productController = ProductController();
  List<CartModel> cartList = [];
  final user = FirebaseAuth.instance.currentUser;

  void _increment(int index, String cartId) async {
    final newQuantity = cartList[index].quantity + 1;

    await cartController.updateQuantity(user!.uid, cartId, newQuantity);
  }

  void _decrement(int index, String cartId) async {
    final currentQuantity = cartList[index].quantity;
    if (currentQuantity > 1) {
      final newQuantity = currentQuantity - 1;

      await cartController.updateQuantity(user!.uid, cartId, newQuantity);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Số lượng tối thiểu là 1')),
      );
    }
  }

  double _caculate(String price, int quantity) {
    double parsedPrice = double.parse(price);
    return parsedPrice * quantity;
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // Nếu chưa đăng nhập, điều hướng sang trang đăng nhập
      Future.microtask(() {
        context.push('/login'); // Thay '/login' bằng route name của bạn
      });

      return const Center(child: CircularProgressIndicator()); // Hiển thị tạm loading
    }

    return StreamBuilder(
        stream:
            cartController.getUserCart(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Giỏ hàng trống'));
          }

          cartList = snapshot.data!;

          return ListView.separated(
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSizes.spaceBtwSections),
            shrinkWrap: true,
            itemCount: cartList.length,
            itemBuilder: (_, index) {
              final cartItem = cartList[index];
              final quantity = cartItem.quantity;

              return StreamBuilder(
                stream: productController
                    .streamProductFromRef(cartItem.productRef!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final product = snapshot.data!;

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.defaultSpace),
                      child: Column(
                        children: [
                          CartItem(product: product, color: cartItem.color),
                          if (widget.showAddRemoveBtn)
                            const SizedBox(height: AppSizes.spaceBtwItems),
                          if (widget.showAddRemoveBtn)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 85),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () => _decrement(
                                              index, cartItem.id ?? ''),
                                          child: CircularIcon(
                                            icon: Icons.remove,
                                            width: 32,
                                            height: 32,
                                            size: AppSizes.md,
                                            color: dark
                                                ? AppColors.white
                                                : AppColors.black,
                                            backgroundColor: dark
                                                ? AppColors.darkerGrey
                                                : AppColors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: AppSizes.spaceBtwItems),
                                        Text('$quantity',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                        const SizedBox(
                                            width: AppSizes.spaceBtwItems),
                                        GestureDetector(
                                          onTap: () => _increment(
                                              index, cartItem.id ?? ''),
                                          child: const CircularIcon(
                                            icon: Icons.add,
                                            width: 32,
                                            height: 32,
                                            size: AppSizes.md,
                                            color: AppColors.white,
                                            backgroundColor: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                ProductPriceText(
                                    price: _caculate(product.price, quantity)
                                        .toString()) // hiện đúng giá
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
