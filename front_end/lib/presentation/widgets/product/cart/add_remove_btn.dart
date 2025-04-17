import 'package:flutter/material.dart';
import 'package:front_end/controller/cart_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';

class AddRemoveBtn extends StatefulWidget {
  const AddRemoveBtn({super.key, required this.quantity});

  final int quantity;
  

  @override
  State<AddRemoveBtn> createState() => _AddRemoveBtnState();
}

class _AddRemoveBtnState extends State<AddRemoveBtn> {

  late int _quantity;
  final CartController cartController = CartController();

  @override
  void initState() {
    super.initState();
   _quantity = widget.quantity;
  }

  void _increment() async {
    
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _decrement,
          child: CircularIcon(
            icon: Icons.remove,
            width: 32,
            height: 32,
            size: AppSizes.md,
            color: dark ? AppColors.white : AppColors.black,
            backgroundColor: dark ? AppColors.darkerGrey : AppColors.white,
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        Text('$_quantity', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: AppSizes.spaceBtwItems),
        GestureDetector(
          onTap: _increment,
          child: CircularIcon(
            icon: Icons.add,
            width: 32,
            height: 32,
            size: AppSizes.md,
            color: AppColors.white,
            backgroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
