import 'package:flutter/material.dart';
import 'package:front_end/controller/category_controller.dart';

class CardProduct extends StatefulWidget {
  const CardProduct({
    super.key,
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.imageURL,
    required this.onEdit,
    required this.onDelete,
  });

  final String id, name, categoryId, price, imageURL;
  final VoidCallback onEdit, onDelete;

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  final CategoryController categoryController = CategoryController();
  String _categoryName = 'Đang tải...';

  @override
  void initState() {
    super.initState();
    _loadCategoryName();
  }

  // Hàm để lấy tên loại sản phẩm từ ID
  Future<void> _loadCategoryName() async {
    final category = await categoryController.getCategoryById(widget.categoryId);
    setState(() {
      _categoryName = category.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: ListTile(
        leading: Image.network(widget.imageURL),
        title: Text(widget.name, style: Theme.of(context).textTheme.titleMedium!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loại: $_categoryName',
              style: Theme.of(context).textTheme.titleSmall!.apply(color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              'Giá: ${widget.price} Đồng',
              style: Theme.of(context).textTheme.titleSmall!.apply(color: Colors.red),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: widget.onEdit,
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
