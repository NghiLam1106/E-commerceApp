import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';

class AppGridLayout extends StatelessWidget {
  const AppGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: mainAxisExtent,
            crossAxisSpacing: AppSizes.gridViewSpacing,
            mainAxisSpacing: AppSizes.gridViewSpacing),
        itemBuilder: itemBuilder);
  }
}
