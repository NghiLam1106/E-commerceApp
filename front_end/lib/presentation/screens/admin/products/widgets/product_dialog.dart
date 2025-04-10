import 'package:flutter/material.dart';
import 'package:front_end/controller/category/category_controller.dart';
import 'dart:io';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/controller/image/image_controller.dart';
import 'package:front_end/controller/product/product_controller.dart';
import 'package:front_end/core/constants/sizes.dart';
import 'package:front_end/model/categories_model.dart';
import 'package:front_end/model/product_model.dart';

class ProductDialog extends StatefulWidget {
  final String? id;
  final String? name;
  final String? categoryId;
  final String? price;
  final List<String>? imageURLs;
  final String? description;
  final String? brand;
  final List<String>? colors;

  const ProductDialog({
    super.key,
    this.id,
    this.name,
    this.categoryId,
    this.price,
    this.imageURLs,
    this.description,
    this.brand,
    this.colors,
  });

  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  // Khai báo các controller
  final imageController = ImageController();
  final ProductController productController = ProductController();
  final CategoryController categoryController = CategoryController();

  // Khai báo các TextEditingController
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  // Khai báo biến để lưu danh sách loại sản phẩm và ID loại sản phẩm đã chọn
  List<CategoryModel> _categories = [];
  String? _selectedCategoryId;

  // Khai báo biến để lưu hình ảnh và URL hình ảnh
  final List<String> _imageURLs = [];

  final List<String> _availableColors = [
    'Black',
    'Red',
    'Blue',
    'Pink',
    'White'
  ];
  final List<String> _selectedColors = [];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? '';
    _selectedCategoryId = widget.categoryId ?? '';
    priceController.text = widget.price ?? '';
    _imageURLs.addAll(widget.imageURLs ?? []);
    descriptionController.text = widget.description ?? '';
    brandController.text = widget.brand ?? '';
    _selectedColors.addAll(widget.colors ?? []);

    _getCategoryNames();
  }

  // Hàm để chọn hình ảnh và lưu trên Cloudinary
  Future<void> _pickImage() async {
    final pickedFile = await imageController.imagePicker();
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);

      final url = await imageController.saveImageLocally(imageFile);
      setState(() {
        _imageURLs.add(url);
      });
    }
  }

  // Hàm để lấy danh sách loại sản phẩm từ Firestore
  Future<void> _getCategoryNames() async {
    final categories = await categoryController.getCategories();
    setState(() {
      _categories = categories;
    });
  }

  Future<bool> _validation() async {
    if (nameController.text.isEmpty) {
      return false;
    }
    if (_selectedCategoryId == null) {
      return false;
    }
    if (priceController.text.isEmpty) {
      return false;
    }
    if (descriptionController.text.isEmpty) {
      return false;
    }
    if (brandController.text.isEmpty) {
      return false;
    }
    if (_imageURLs.isEmpty) {
      return false;
    }
    if (_selectedColors.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.id != null ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Tên sản phẩm
            TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Tên sản phẩm')),
            SizedBox(height: AppSizes.spaceBtwItems),
            // Mô tả sản phẩm
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Giới thiệu sản phẩm')),
            SizedBox(height: AppSizes.spaceBtwItems),
            // Thương hiệu sản phẩm
            TextField(
                controller: brandController,
                decoration: InputDecoration(hintText: 'Thương hiệu sản phẩm')),

            // Loại sản phẩm
            SizedBox(height: AppSizes.spaceBtwItems),
            DropdownButtonFormField<String>(
              value: _selectedCategoryId!.isEmpty
                  ? null
                  : _selectedCategoryId, // Sử dụng null nếu không có giá trị
              hint: const Text('Chọn loại sản phẩm'),
              items: _categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat.id,
                  child: Text(cat.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value ?? '';
                });
              },
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            // Chọn màu
            DropdownButtonFormField<String>(
              hint: const Text('Chọn màu'),
              items: _availableColors.map((color) {
                return DropdownMenuItem<String>(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null && !_selectedColors.contains(value)) {
                  setState(() {
                    _selectedColors.add(value);
                  });
                }
              },
            ),
            SizedBox(height: AppSizes.spaceBtwItems),

            // Hiển thị danh sách màu đã chọn
            Wrap(
              spacing: 8,
              children: _selectedColors.map((color) {
                return Chip(
                  label: Text(color),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    setState(() {
                      _selectedColors.remove(color);
                    });
                  },
                );
              }).toList(),
            ),

            SizedBox(height: AppSizes.spaceBtwItems),

            // Giá sản phẩm
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Giá sản phẩm'),
            ),
            SizedBox(height: AppSizes.spaceBtwItems),

            // Thêm hình ảnh
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
            SizedBox(height: AppSizes.spaceBtwItems),

            // Hiển thị danh sách ảnh
            _imageURLs.isEmpty
                ? const Text('Chưa có ảnh nào')
                : Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _imageURLs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final url = entry.value;
                      return Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _imageURLs.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                color: Colors.black54,
                                child: const Icon(Icons.close,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (widget.id == null &&
                await _validation()) {

              final newProduct = ProductModel(
                name: nameController.text,
                price: priceController.text, // Convert String → double
                categoryId: _selectedCategoryId ?? '',
                imageUrls: _imageURLs,
                description: descriptionController.text,
                brand: brandController.text,
                colors: _selectedColors,
              );

              // Nếu không có id thì thêm mới
              productController.addProduct(newProduct);
            } else if (widget.id != null &&
                await _validation()) {
              // Nếu có id thì cập nhật
              productController.updateProduct(
                ProductModel(
                  id: widget.id,
                  name: nameController.text,
                  price: priceController.text,
                  categoryId: _selectedCategoryId ?? '',
                  imageUrls: _imageURLs,
                  description: descriptionController.text,
                  brand: brandController.text,
                  colors: _selectedColors,
                ),
              );
            } else{
              // Nếu không có id thì thêm mới
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vui lòng nhập đầy đủ thông tin'),
                ),
              );
            }
            nameController.clear();
            _selectedCategoryId = null;
            priceController.clear();
            _imageURLs.clear();
            _selectedColors.clear();
            descriptionController.clear();
            brandController.clear();
            Navigator.of(context).pop();
          },
          child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(widget.id != null ? 'Cập nhật' : 'Thêm')),
        ),
      ],
    );
  }
}
