import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/product_controller.dart';
import 'package:front_end/core/utils/dialog_utils.dart';
import 'package:front_end/presentation/screens/admin/products/widgets/card_product.dart';
import 'package:front_end/presentation/screens/admin/products/widgets/product_dialog.dart';

class ListviewProduct extends StatelessWidget {
  const ListviewProduct({
    super.key,
    required this.productsList,
  });

  final List<DocumentSnapshot<Object?>> productsList;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = ProductController();
    return ListView.builder(
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        DocumentSnapshot doc = productsList[index];
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
        return CardProduct(
            name: data['name'],
            categoryId: data['categoryId'],
            price: data['price'],
            imageURL: data['imageUrls'][0],
            id: doc.id,
            onDelete: () => showDeleteConfirmationDialog(
                  context: context,
                  onConfirm: () {
                    productController.removeProduct(doc.id);
                  },
                ),
            onEdit: () => showDialog(
                context: context,
                builder: (context) => ProductDialog(
                      id: doc.id,
                      name: data['name'],
                      categoryId: data['categoryId'],
                      price: data['price'],
                      imageURLs: (data['imageUrls'] as List<dynamic>)
                          .cast<String>(),
                      description: data['description'],
                      brandId: data['brandId'],
                      colors: (data['colors'] as List<dynamic>)
                          .cast<String>(),
                    )));
      },
    );
  }
}
