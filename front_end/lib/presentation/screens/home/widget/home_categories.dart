import 'package:flutter/material.dart';
import 'package:front_end/model/categories_model.dart';
import 'package:front_end/presentation/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:go_router/go_router.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categories[index];
            return VerticalImageText(
              image: category.imageUrl,
              title: category.name,
              isNetworkImage: true,
              onTap: () {
                context.push('/'); // Điều hướng đến danh sách sản phẩm theo danh mục
                                  // Chưa xử lý còn chờ làm thêm trang danh sách sản phẩm theo danh mục
              },
            );
          }),
    );
  }
}
