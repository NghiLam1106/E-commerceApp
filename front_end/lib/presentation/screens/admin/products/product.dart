import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/product/product_controller.dart';
import 'package:front_end/core/utils/dialog_utils.dart';
import 'package:front_end/presentation/screens/admin/products/widgets/listview_product.dart';
import 'package:front_end/presentation/screens/admin/products/widgets/product_dialog.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController productController = ProductController();
  final TextEditingController searchController = TextEditingController();

  bool isPriceDescending = true;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value; // ✅ Lưu lại giá trị tìm kiếm
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: Icon(Icons.filter_alt),
                onPressed: () {
                  setState(() {
                    isPriceDescending = !isPriceDescending;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
  stream: productController.getProducts(
    isPriceDescending: isPriceDescending,
    name: searchController.text,
  ),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text("Không tìm thấy sản phẩm nào."));
    }

    List<DocumentSnapshot> productsList = snapshot.data!.docs;

    return ListView.builder(
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        DocumentSnapshot doc = productsList[index];
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return ListviewProduct(
          name: data['name'],
          categoryId: data['categoryId'],
          price: data['price'],
          imageURL: data['imageUrl'][0],
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
            imageURLs: (data['imageUrl'] as List<dynamic>).cast<String>(),       
            description: data['description'],
            brand: data['brand'],
            colors: (data['colors'] as List<dynamic>).cast<String>(),    
          )
          )
        );
      },
    );
  },
),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ProductDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}