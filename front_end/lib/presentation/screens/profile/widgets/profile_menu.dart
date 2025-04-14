import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon = Icons.arrow_forward,
    required this.onTap,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text('$title:',
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis)),
            Expanded(
                flex: 5,
                child: Text(value,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis)),
            // Expanded(child: Icon(icon, size: 18))
            
          ],
        ),
      ),
    );
  }
}
