import 'package:flutter/material.dart';
import '../l10n/l10n.dart';

class ProjectGithubLink extends StatelessWidget {
  const ProjectGithubLink({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(Icons.arrow_forward, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(
          context.l10n.viewOnGithub,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
