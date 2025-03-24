import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(
        showBackArrow: true,
        title: Text('Add new Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  label: Text('name')
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputField),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  label: Text('Phone number')
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputField),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  label: Text('Address')
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputField),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text('Save')),)
            ],
          )),
        ),
      ),
    );
  }
}
