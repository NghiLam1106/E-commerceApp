import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/core/utils/calculate_sum_price.dart';

class BillingAmountSection extends StatefulWidget {
  const BillingAmountSection({super.key});


  @override
  State<BillingAmountSection> createState() => _BillingAmountSectionState();
}

class _BillingAmountSectionState extends State<BillingAmountSection> {
  String price = '';
    final CartController cartController = CartController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

    void _getData() async {
    final data = await cartController
        .getUserCartFuture(FirebaseAuth.instance.currentUser!.uid);
    final calculate = await calculateSumPrice(cartList: data);
    setState(() {
      price = calculate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng số tiền:',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('$price₫',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
