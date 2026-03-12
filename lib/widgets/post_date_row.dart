import 'package:flutter/material.dart';

class PostDateRow extends StatelessWidget {
  final String formattedDate;

  const PostDateRow({super.key, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtleColor = theme.colorScheme.onSurface.withValues(alpha: 0.5);
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 14, color: subtleColor),
        const SizedBox(width: 6),
        Text(
          formattedDate,
          style: theme.textTheme.bodySmall?.copyWith(color: subtleColor),
        ),
      ],
    );
  }
}
