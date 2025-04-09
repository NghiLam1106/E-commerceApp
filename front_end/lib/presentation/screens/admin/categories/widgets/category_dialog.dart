import 'package:flutter/material.dart';
import 'package:front_end/controller/category/category_controller.dart';
import 'dart:io';
import 'package:front_end/controller/image/image_controller.dart';
import 'package:front_end/core/constants/image_string.dart';

class CategoryDialog extends StatefulWidget {
  final String? id;
  final String? name;
  final String? imageURL;

  const CategoryDialog({
    super.key,
    this.id,
    this.name,
    this.imageURL,
  });

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  // Khai báo các controller
  final imageController = ImageController();
  final CategoryController categoryController = CategoryController();

  // Khai báo các TextEditingController
  final TextEditingController nameController = TextEditingController();

  // Khai báo biến để lưu hình ảnh và URL hình ảnh
  File? _image;
  String? _imageURL;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? '';
    _imageURL = widget.imageURL;
  }

  // Hàm để chọn hình ảnh và lưu trên Cloudinary
  Future<void> _pickImage() async {
    // Chọn hình ảnh từ thư viện
    final pickedFile = await imageController.imagePicker();
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    // Lưu hình ảnh lên Cloudinary và lấy URL
    await imageController.saveImageLocally(_image!).then((value) {
      setState(() {
        _imageURL = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.id != null ? 'Cập nhật loại sản phẩm' : 'Thêm loại sản phẩm'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Tên'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await _pickImage();
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  AppImages.add,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            if (_image != null)
              Image.file(_image!, height: 120, width: 100, fit: BoxFit.cover)
            else if (_imageURL != null)
              Image.network(_imageURL!,
                  height: 120, width: 100, fit: BoxFit.cover),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.id == null &&
                _imageURL != null &&
                nameController.text.isNotEmpty) {
              // Nếu không có id thì thêm mới
              categoryController.addCategory(nameController.text, _imageURL!);
            } else if (widget.id != null &&
                _imageURL != null &&
                nameController.text.isNotEmpty) {
              // Nếu có id thì cập nhật
              categoryController.updateProduct(
                widget.id!,
                nameController.text,
                _imageURL!,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lỗi: Vui lòng nhập đầy đủ thông tin')),
              );
            }

            nameController.clear();
            _image = null;
            _imageURL = null;
            Navigator.of(context).pop();
          },
          child: Text(widget.id != null ? 'Cập nhật' : 'Thêm'),
        ),
      ],
    );
  }
}
