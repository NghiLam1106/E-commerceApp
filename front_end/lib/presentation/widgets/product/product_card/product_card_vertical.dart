import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/brand_controller.dart';
import 'package:front_end/controller/favorites_controller.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/constants/enums.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/model/brand_model.dart';
import 'package:front_end/model/favorites_model.dart';
import 'package:front_end/model/product_model.dart';
import 'package:front_end/presentation/styles/shadows.dart';
import 'package:front_end/presentation/widgets/container/rounded_container.dart';
import 'package:front_end/presentation/widgets/icon/circular_icon.dart';
import 'package:front_end/presentation/widgets/image/rounded_image.dart';
import 'package:front_end/presentation/widgets/texts/brand_title_and_verify_icon.dart';
import 'package:front_end/presentation/widgets/texts/product_price_text.dart';
import 'package:front_end/presentation/widgets/texts/product_title_text.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProductCardVertical extends StatefulWidget {
  final ProductModel? product;

  const ProductCardVertical(
      {super.key,
      this.product,
      });

  @override
  State<ProductCardVertical> createState() => _ProductCardVerticalState();
}

class _ProductCardVerticalState extends State<ProductCardVertical> {
  // controller
  final BrandController brandController = BrandController();
  final FavoritesController favoritesController = FavoritesController();
  final ProductController productController = ProductController();

  var currentUser = FirebaseAuth.instance.currentUser;
  List<FavoritesModel> _favouriteList = [];

  BrandModel? brand;

  bool _isLoadingBrand = true;
  bool isFavorited = false;

  late String name;
  late String price;
  late String brandId;
  late String imageUrl;
  late String productId;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      productId = widget.product!.id!;
      name = widget.product!.name;
      price = widget.product!.price;
      brandId = widget.product!.brandId;
      imageUrl = widget.product!.imageUrls[0];
    } 
    _loadBrand();
    _loadFavorites();
  }

  // load brand của sản phẩm bằng brandId
  Future<void> _loadBrand() async {
    final fetchedBrand = await brandController.getBrandById(brandId);
    setState(() {
      brand = fetchedBrand;
      _isLoadingBrand = false;
    });
  }

  // kiểm tra xem người dùng có yêu thích sản phẩm hay kh
  Future<void> _loadFavorites() async {
    if (currentUser != null) {
      final favorites =
          await favoritesController.getFavoritesForProduct(currentUser!.uid);

      setState(() {
        _favouriteList = favorites;
        isFavorited =
            favorites.any((favorite) => favorite.productId == productId);
      });
    }
  }

  // xử lý khi nhấn yêu thích
  Future<void> _onFavoritePressed({
    required String productId,
  }) async {
    if (isFavorited) {
      for (var favorite in _favouriteList) {
        if (favorite.productId == productId) {
          favoritesController.removeFavorites(favorite.id!);
        }
      }
    } else {
      // tạo productref
      final productRef = productController.createRefProduct(productId);
      // tạo FavoritesModel
      FavoritesModel favorite = FavoritesModel(
        productRef: productRef,
        productId: productId,
        userId: currentUser!.uid,
        timestamp: Timestamp.now(),
      );
      // thêm Favorites
      favoritesController.addFavorites(favorite);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        context.push('/detail/$productId');
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark ? AppColors.darkerGrey : AppColors.white,
        ),
        child: Column(
          children: [
            // Thumbnail + Heart icon
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  RoundedImage(
                    imageUrl: imageUrl,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(
                      onPressed: () {
                        // nếu người dùng đã đăng nhập
                        if (currentUser != null) {
                          _onFavoritePressed(
                            productId: productId,
                          );
                          setState(() {
                            isFavorited = !isFavorited;
                          });
                        } else {
                          // nếu không thì điều hướng đến tran login
                          context.push('/login');
                        }
                      },
                      icon: Iconsax.heart,
                      color: isFavorited ? Colors.red : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),

            // Thông tin sản phẩm
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProductTitleText(title: name, smallSize: true),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  _isLoadingBrand
                      ? const SizedBox(height: 20)
                      : BrandTitleAndVerifyIcon(
                          title: brand!.name,
                          brandTextSize: TextSizes.medium,
                        ),
                ],
              ),
            ),

            const Spacer(),

            // Price + Add button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.sm),
                  child: ProductPriceText(price: price),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.cardRadiusMd),
                      bottomRight: Radius.circular(AppSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: AppSizes.iconLg,
                    height: AppSizes.iconLg,
                    child: Center(
                      child: Icon(Icons.add, color: AppColors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
