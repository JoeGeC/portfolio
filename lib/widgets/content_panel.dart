import 'package:flutter/material.dart';
import '../app_constants.dart';

class ContentPanel extends StatelessWidget {
  const ContentPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.contentMaxWidth),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              surfaceTintColor: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(AppLayout.pagePaddingH),
                child: child,
              ),
            ),
          ),
        ),
      );
}
