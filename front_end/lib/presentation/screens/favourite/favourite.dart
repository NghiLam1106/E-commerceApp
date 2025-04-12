import 'package:flutter/material.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/widgets/appbar/appbar.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';
import 'package:front_end/presentation/widgets/layout/grid_layout.dart';
import 'package:front_end/presentation/widgets/product/product_card/product_card_vertical.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
      List<ProductModel> _productsList = [];
    final ProductController productController = ProductController();

    @override
  void initState() {
    super.initState();
    _getProductsList();
  }

  Future<void> _getProductsList() async {
    final products = await productController.getProductsList();
    setState(() {
      _productsList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        title: Text(
          "Favourite",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () {
              context.push('/homne');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              AppGridLayout(
                itemCount: _productsList.length,
                itemBuilder: (_, items) => ProductCardVertical(product: _productsList[items],),
              )
            ],
          ),
        ),
      ),
    );
  }
}