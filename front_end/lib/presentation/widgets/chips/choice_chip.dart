import 'package:flutter/material.dart';
import 'package:front_end/core/utils/Helper/helper_functions.dart';
import 'package:front_end/presentation/widgets/container/circular_container.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onSelected,
  });

  final String text;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = AppHelperFunction.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : const Text(''),
        selected: isSelected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: isSelected ? Colors.white : null),
        avatar: isColor
            ? AppCircularContainer(
              height: 50,
              width: 50,
              backgroundColor: AppHelperFunction.getColor(text)!,
              )
            : null,
        shape: isColor ? const CircleBorder() : null,
        labelPadding: isColor ? EdgeInsets.all(0) : null,
        backgroundColor: isColor ? AppHelperFunction.getColor(text) : null,
      ),
    );
  }
}