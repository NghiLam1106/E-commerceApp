import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/order_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/order_model.dart';
import 'package:front_end/presentation/screens/oder/widgets/order_list_items.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController orderController = OrderController();
  List<OrderModel> orderList = [];
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final data = await orderController.getOrderByIdUser(user!.uid);
    setState(() {
      orderList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        showBackArrow: true,
        title: Text(
          'Đơn đặt hàng của tôi',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: orderList.isEmpty
          ? Center(
              child: Text('Bạn chưa đặt đơn hàng nào.'),
            )
          : Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: OrderListItems(orderList: orderList),
            ),
    );
  }
}
