import 'package:flutter/material.dart';

class ProjectImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double height;

  const ProjectImage({
    super.key,
    required this.assetPath,
    this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _Fallback(
          width: width,
          height: height,
          theme: theme,
        ),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  final double? width;
  final double height;
  final ThemeData theme;

  const _Fallback({this.width, required this.height, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.code, size: 48, color: theme.colorScheme.primary),
    );
  }
}
