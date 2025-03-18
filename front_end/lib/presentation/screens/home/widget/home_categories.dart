import 'package:flutter/material.dart';
import 'package:front_end/core/constants/image_string.dart';
import 'package:front_end/presentation/widgets/image_text_widgets/vertical_image_text.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return VerticalImageText(image: AppImages.phone,title: "Phone",onTap: (){},);
          }),
    );
  }
}

