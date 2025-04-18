import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/screens/address/widgets/single_address.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:go_router/go_router.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool selectedAddress = false;

  /// Tạo key để buộc `SingleAddress` rebuild lại khi thay đổi
  Key _addressListKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await context.push('/newAddress');
          if (result == true) {
            /// Thay key mới => ép `SingleAddress` gọi lại `initState()`
            setState(() {
              _addressListKey = UniqueKey();
            });
          }
        },
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      appBar: AppbarCustom(
        showBackArrow: true,
        title:
            Text('Địa chỉ', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              SingleAddress(
                key: _addressListKey, // ép reload Future
                onTap: (address) {
                  selectedAddress = true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
