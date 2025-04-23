import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/address_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/address_model.dart';
import 'package:front_end/presentation/screens/address/widgets/single_address.dart';
import 'package:front_end/presentation/widgets/texts/section_heading.dart';

class BillingAddressSection extends StatefulWidget {
  const BillingAddressSection({super.key, required this.activeAddresses});

  final List<AddressModel> activeAddresses;

  @override
  State<BillingAddressSection> createState() => _BillingAddressSectionState();
}

class _BillingAddressSectionState extends State<BillingAddressSection> {
  final user = FirebaseAuth.instance.currentUser;
  final AddressController addressController = AddressController();
  List<AddressModel> addressList = [];

  @override
  void initState() {
    super.initState();
    //getdata();
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
            padding: EdgeInsets.all(AppSizes.spaceBtwItems),
            child: SingleAddress());
      },
    );
  }

  Future<void> getdata() async {
    final data = await addressController.getAddressByUserId(user!.uid);
    final addressActive = data.where((e) => e.status == 'active').toList();
    setState(() {
      addressList = addressActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppSectionHeading(
        title: 'Địa chỉ nhận hàng',
        buttonTitle: 'Thay đổi',
        onPressed: () {
          _showModalBottomSheet(context);
        },
      ),
      Column(
        children: widget.activeAddresses
            .map((e) => InformationAddress(address: e))
            .toList(),
      )
    ]);
  }
}

class InformationAddress extends StatelessWidget {
  const InformationAddress({
    super.key,
    required this.address,
  });

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          address.name,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.darkerGrey, size: 16),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(address.phoneNumber,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.location_city,
                color: AppColors.darkerGrey, size: 16),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              address.address,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ),
          ],
        ),
      ],
    );
  }
}
