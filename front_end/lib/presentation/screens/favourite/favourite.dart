import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/favorites_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/favorites_model.dart';
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
  List<FavoritesModel> _favouriteList = [];
  final FavoritesController favoritesController = FavoritesController();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    if (currentUser != null) {
      final favorites = await favoritesController.getReviewsForProduct(currentUser!.uid);

      setState(() {
        _favouriteList = favorites;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        title: Text(
          "Sản phẩm yêu thích",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () {
              context.push('/search');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              _favouriteList.isEmpty? 
                Center(child: Text('Bạn chưa yêu thích sản phẩm nào',style: Theme.of(context).textTheme.headlineSmall,))
              :
              AppGridLayout(
                itemCount: _favouriteList.length,
                itemBuilder: (_, items) => ProductCardVertical(
                  name: _favouriteList[items].nameProduct,
                  brand: _favouriteList[items].brandId,
                  imageUrl: _favouriteList[items].imageUrlProduct,
                  price: _favouriteList[items].priceProduct,
                  productId: _favouriteList[items].productId,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
