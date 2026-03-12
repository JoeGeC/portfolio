import 'package:flutter/material.dart';
import '../models/project.dart';
import 'technology_chips.dart';

class ProjectInfo extends StatelessWidget {
  final Project project;

  const ProjectInfo({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(project.description, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 12),
        TechnologyChips(technologies: project.technologies),
      ],
    );
  }
}
