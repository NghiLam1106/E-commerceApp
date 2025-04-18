import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:go_router/go_router.dart';

class ListViewOrder extends StatelessWidget {
  const ListViewOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final order = Order(
          id: 'ORD00${index + 1}',
          customer: 'Khách hàng ${index + 1}',
          status: index % 2 == 0 ? 'Đang xử lý' : 'Hoàn thành',
        );
    
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
          child: ListTile(
            leading: const Icon(Icons.receipt_long),
            title: Text('Mã đơn: ${order.id}'),
            subtitle: Text('Khách: ${order.customer}'),
            trailing: Text(
              order.status,
              style: TextStyle(
                color: order.status == 'Hoàn thành'
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              context.push('/admin/orders/${order.id}');
            },
          ),
        );
      },
    );
  }
}

class Order {
  final String id;
  final String customer;
  final String status;

  Order({required this.id, required this.customer, required this.status});
}