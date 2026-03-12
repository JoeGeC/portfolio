import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../models/project.dart';
import '../utils/url_launcher_utils.dart';
import 'project_github_link.dart';
import 'project_image.dart';
import 'technology_chips.dart';

class ProjectListItem extends StatelessWidget {
  final Project project;

  const ProjectListItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > AppLayout.breakpointWide;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => launchExternalUrl(project.readmePageUrl),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isWide
              ? _WideLayout(project: project)
              : _NarrowLayout(project: project),
        ),
      ),
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  final Project project;

  const _ProjectDetails({required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(project.description, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 16),
        TechnologyChips(technologies: project.technologies),
        const SizedBox(height: 12),
        const ProjectGithubLink(),
      ],
    );
  }
}

class _WideLayout extends StatelessWidget {
  final Project project;

  const _WideLayout({required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectImage(assetPath: project.imageAsset, width: 180, height: 140),
        const SizedBox(width: 20),
        Expanded(child: _ProjectDetails(project: project)),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final Project project;

  const _NarrowLayout({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: ProjectImage(assetPath: project.imageAsset, height: 160)),
        const SizedBox(height: 16),
        _ProjectDetails(project: project),
      ],
    );
  }
}
