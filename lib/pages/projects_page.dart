import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../l10n/l10n.dart';
import '../models/project.dart';
import '../widgets/content_panel.dart';
import '../widgets/project_list_item.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.pagePaddingH,
          vertical: AppLayout.pagePaddingV,
        ),
        child: ContentPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PageHeader(),
              const SizedBox(height: 24),
              ..._projectItems(context),
            ],
          ),
        ),
      );

  List<Widget> _projectItems(BuildContext context) => Project.all
      .map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ProjectListItem(project: p),
          ))
      .toList();
}

class _PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.projects,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.projectsSubtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
