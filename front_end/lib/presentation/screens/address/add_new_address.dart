import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/address_controller.dart';
import 'package:front_end/controller/user/user_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/address_model.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  final String userId = '';

  @override
  State<AddNewAddressScreen> createState() => AddNewAddressScreenState();
}

class AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final UserController userModel = UserController();
  final AddressController addressController1 = AddressController();

  bool _isLoading = true;

  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: const AppbarCustom(
          showBackArrow: true,
          title: Text('Thêm địa chỉ mới'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.user), label: Text('Họ và tên')),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputField),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      label: Text('Số điện thoại')),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputField),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile), label: Text('Địa chỉ')),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputField),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      AddressModel addressModel = AddressModel(
                        uid: user!.uid,
                        name: nameController.text,
                        phoneNumber: phoneController.text,
                        address: addressController.text,
                      );
                      addressController1.addAddress(addressModel);
                      Navigator.pop(context,
                          true); // Trả về giá trị true khi lưu thành công
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thêm địa chỉ thành công'),
                        ),
                      );
                    },
                    child: Text('Lưu'),
                  ),
                )
              ],
            )),
          ),
        ),
      );
    }
  }
}
