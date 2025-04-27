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
  final _formKey = GlobalKey<FormState>(); // Thêm key để validate form

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
      return const Center(child: CircularProgressIndicator());
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
              key: _formKey, // Gán form key
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: 'Họ và tên',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập họ và tên';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputField),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Số điện thoại',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      if (value.length < 9 || value.length > 11) {
                        return 'Số điện thoại không hợp lệ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputField),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.location),
                      labelText: 'Địa chỉ',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập địa chỉ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputField),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          AddressModel addressModel = AddressModel(
                            uid: user!.uid,
                            name: nameController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            address: addressController.text.trim(),
                          );
                          await addressController1.addAddress(addressModel);
                          if (context.mounted) {
                            Navigator.pop(context, true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Thêm địa chỉ thành công')),
                            );
                          }
                        }
                      },
                      child: const Text('Lưu'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
