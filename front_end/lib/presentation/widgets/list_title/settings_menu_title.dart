import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';

class SettingsMenuTitle extends StatelessWidget {
  const SettingsMenuTitle(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.trailing,
      this.onTap});

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, size: 28, color: AppColors.primary),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        trailing: trailing,
      ),
    );
  }
}
