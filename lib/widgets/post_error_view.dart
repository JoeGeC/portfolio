import 'package:flutter/material.dart';

class PostErrorView extends StatelessWidget {
  final String message;

  const PostErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: theme.colorScheme.error)),
        ],
      ),
    );
  }
}
