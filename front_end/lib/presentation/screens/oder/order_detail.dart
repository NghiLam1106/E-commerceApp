import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/address_controller.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/controller/order_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/core/utils/calculate_sum_price.dart';
import 'package:front_end/model/cart_model.dart';
import 'package:front_end/model/order_model.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:front_end/presentation/widgets/product/cart/cart_item.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final OrderController orderController = OrderController();
  final CartController cartController = CartController();
  final ProductController productController = ProductController();
  final AddressController addressController = AddressController();
  final user = FirebaseAuth.instance.currentUser;

  late Future<OrderModel> futureOrder;
  List<CartModel> cartList = [];
  String totalPrice = "";
  late Future<void> loadDataFuture;

  @override
  void initState() {
    super.initState();
    futureOrder = orderController.getOrderById(widget.orderId);
    loadDataFuture = loadData();
  }

  Future<void> loadData() async {
    final order = await futureOrder;

    final carts = await Future.wait(
        order.cartRef.map((ref) => cartController.getCartFromRef(ref)));
    final calculatedTotalPrice = await calculateSumPrice(cartList: carts);

    setState(() {
      cartList = carts;
      totalPrice = calculatedTotalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppbarCustom(
        showBackArrow: true,
        title: Text('Chi tiết đơn hàng',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: FutureBuilder<void>(
          future: loadDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Không thể tải đơn hàng'));
            }

            return ListView(
              children: [
                ...cartList.map((cart) => FutureBuilder(
                      future: productController.getProductFromRef(cart.productRef!),
                      builder: (context, productSnapshot) {
                        if (!productSnapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        final product = productSnapshot.data!;
                        return RoundedContainer(
                          padding: const EdgeInsets.all(AppSizes.defaultSpace),
                          backgroundColor: AppColors.light,
                          child: CartItem(product: product, color: cart.color));
                      },
                    )),
                const SizedBox(height: AppSizes.spaceBtwItems),
                RoundedContainer(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  showBorder: true,
                  backgroundColor: dark ? AppColors.black : AppColors.white,
                  child: Column(
                    children: [
                      // Tổng tiền
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tổng số tiền:',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text('$totalPrice đ',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems),

                      const Divider(),
                      const SizedBox(height: AppSizes.spaceBtwItems),

                      AppSectionHeading(
                          title: 'Địa chỉ nhận hàng', showActionButton: false),
                      const SizedBox(height: AppSizes.spaceBtwItems),
                      // Thông tin địa chỉ
                      FutureBuilder<OrderModel>(
                        future: futureOrder,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox.shrink();
                          }
                          final order = snapshot.data!;
                          return FutureBuilder(
                            future: addressController
                                .getAddressFromRef(order.addressRef),
                            builder: (context, addressSnapshot) {
                              if (!addressSnapshot.hasData) {
                                return const SizedBox.shrink();
                              }
                              final address = addressSnapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tên người nhận: ${address.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  const SizedBox(
                                      height: AppSizes.spaceBtwItems / 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          color: AppColors.darkerGrey,
                                          size: 16),
                                      const SizedBox(
                                          width: AppSizes.spaceBtwItems),
                                      Text('Số điện thoại: ${address.phoneNumber}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: AppSizes.spaceBtwItems / 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_city,
                                          color: AppColors.darkerGrey,
                                          size: 16),
                                      const SizedBox(
                                          width: AppSizes.spaceBtwItems),
                                      Expanded(
                                        child: Text('Địa chỉ: ${address.address}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            softWrap: true),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
