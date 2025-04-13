import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/brand_controller.dart';
import 'package:front_end/core/utils/dialog_utils.dart';
import 'package:front_end/presentation/screens/admin/brands/widgets/brand_dialog.dart';
import 'package:front_end/presentation/screens/admin/brands/widgets/listview_brand.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  final BrandController brandController = BrandController();
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
                  hintText: 'Tìm kiếm thương hiệu sản phẩm...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
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
        stream: brandController.getBrandsList(
          name: searchController.text,
          isPriceDescending: isPriceDescending,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Không tìm thấy thương hiệu sản phẩm nào."));
          }

          List<DocumentSnapshot> productsList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = productsList[index];
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              return ListviewBrand(
                  name: data['name'],
                  imageURL: data['imageUrl'],
                  id: doc.id,
                  onDelete: () => showDeleteConfirmationDialog(
                        context: context,
                        onConfirm: () {
                          brandController.removeBrand(doc.id);
                        },
                      ),
                  onEdit: () => showDialog(
                        context: context,
                        builder: (context) => BrandDialog(
                          id: doc.id,
                          name: data['name'],
                          imageURL: data['imageUrl'],
                        ),
                      ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => BrandDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
