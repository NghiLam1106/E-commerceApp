import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controller/category_controller.dart';
import 'package:front_end/core/utils/dialog_utils.dart';
import 'package:front_end/presentation/screens/admin/categories/widgets/category_dialog.dart';
import 'package:front_end/presentation/screens/admin/categories/widgets/listview_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryController categoryController = CategoryController();
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
                  hintText: 'Tìm kiếm loại sản phẩm...',
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
        stream: categoryController.getcategories(
          name: searchController.text,
          isPriceDescending: isPriceDescending,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Không tìm thấy loại sản phẩm nào."));
          }

          List<DocumentSnapshot> productsList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = productsList[index];
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              return ListviewCategory(
                  name: data['name'],
                  imageURL: data['imageUrl'],
                  id: doc.id,
                  onDelete: () => showDeleteConfirmationDialog(
                        context: context,
                        onConfirm: () {
                          categoryController.removeCategory(doc.id);
                        },
                      ),
                  onEdit: () => showDialog(
                        context: context,
                        builder: (context) => CategoryDialog(
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
            builder: (context) => CategoryDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
