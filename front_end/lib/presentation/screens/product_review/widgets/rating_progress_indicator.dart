import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/core/utils/divice/divice_utils.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        Expanded(
          flex: 8,
          child: SizedBox(
          width: AppDeviceUtils.getScreenWidth(context) * 0.8,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 11,
            backgroundColor: AppColors.grey,
            borderRadius: BorderRadius.circular(7),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ))
      ],
    );
  }
}
