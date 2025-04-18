import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/address_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/model/address_model.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SingleAddress extends StatefulWidget {
  final void Function(AddressModel)? onTap;

  const SingleAddress({super.key, this.onTap});

  @override
  State<SingleAddress> createState() => _SingleAddressScreenState();
}

class _SingleAddressScreenState extends State<SingleAddress> {
  bool selectedAddress = false;
  final user = FirebaseAuth.instance.currentUser;
  final AddressController addressController = AddressController();
  late Future<List<AddressModel>> _addressFuture;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  @override
  void didUpdateWidget(covariant SingleAddress oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadAddresses(); // đảm bảo Future được gọi lại khi key thay đổi
  }

  void _loadAddresses() {
    _addressFuture =
        addressController.getAddressByUserId(user!.uid).then((addresses) {
      final activeIndex =
          addresses.indexWhere((address) => address.status == 'active');
      if (activeIndex != -1) {
        selectedIndex = activeIndex;
      }
      return addresses;
    });
  }

  // Cập nhật status của địa chỉ
  void _updateStatus(AddressModel address, {bool isDeselect = false}) async {
    try {
      if (address.id == null) return;

      if (isDeselect) {
        await addressController.updateAddressStatus(address.id!, 'inactive');
      } else {
        await addressController.updateAddressStatus(address.id!, 'active');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return FutureBuilder(
        future: _addressFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Lỗi: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('Không có dữ liệu.'),
            );
          }
          final addressList = snapshot.data!;

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: AppSizes.defaultSpace,
            ),
            shrinkWrap: true,
            itemCount: addressList.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () async {
                  // Nếu có địa chỉ cũ được chọn thì update status = inactive
                  if (selectedIndex != null) {
                    final oldSelectedAddress = addressList[selectedIndex!];
                    _updateStatus(oldSelectedAddress, isDeselect: true);
                  }

                  // Cập nhật selectedIndex sau khi hoàn tất xử lý
                  setState(() {
                    selectedIndex = index;
                  });

                  // Update địa chỉ mới được chọn thành active
                  _updateStatus(addressList[index]);

                  // Gọi callback nếu có
                  if (widget.onTap != null) {
                    widget.onTap!(addressList[index]);
                  }
                },
                child: RoundedContainer(
                  padding: const EdgeInsets.all(AppSizes.md),
                  width: double.infinity,
                  showBorder: true,
                  backgroundColor: isSelected
                      ? AppColors.primary.withOpacity(0.5)
                      : Colors.transparent,
                  borderColor: isSelected
                      ? Colors.transparent
                      : dark
                          ? AppColors.darkerGrey
                          : AppColors.grey,
                  margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 5,
                          top: 0,
                          child: Icon(
                            isSelected ? Iconsax.tick_circle : null,
                            color: isSelected
                                ? dark
                                    ? AppColors.light
                                    : AppColors.dark
                                : null,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addressList[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSizes.sm / 2),
                          Text(
                            addressList[index].phoneNumber,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppSizes.sm / 2),
                          Text(
                            addressList[index].address,
                            softWrap: true,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
