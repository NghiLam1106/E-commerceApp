import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/model/order_model.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key, required this.orderList});
  final List<OrderModel> orderList;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return ListView.separated(
        shrinkWrap: true,
        itemCount: orderList.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: AppSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          final order = orderList[index];
          return OrderCard(dark: dark, order: order);
        });
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.dark,
    required this.order,
  });

  final bool dark;
  final OrderModel order;

  String formatTimestamp(Timestamp timestamp) {
  final DateTime date = timestamp.toDate();
  return DateFormat('dd/MM/yyyy HH:mm').format(date);
}

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: EdgeInsets.all(AppSizes.md),
      showBorder: true,
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.payment),
                  SizedBox(
                    width: AppSizes.spaceBtwItems / 2,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Đã thanh toán',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: AppColors.primary)),
                      Text(formatTimestamp(order.orderDate!),
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  context.push('/orderDetail/${order.id}');
                },
                icon: Icon(Icons.arrow_forward_ios),
                iconSize: AppSizes.iconSm,
              )
            ],
          ),
          const SizedBox(
            width: AppSizes.spaceBtwItems / 2,
          ),
          Row(
            children: [
              Icon(Icons.local_shipping_outlined),
              SizedBox(
                width: AppSizes.spaceBtwItems / 2,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ngày giao hàng',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: AppColors.primary)),
                  Text(formatTimestamp(order.deliveryDate!),
                      style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
