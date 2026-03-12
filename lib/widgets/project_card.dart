import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../models/project.dart';
import '../utils/url_launcher_utils.dart';
import 'project_image.dart';
import 'project_info.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > AppLayout.breakpointWide;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => launchExternalUrl(project.readmePageUrl),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isWide ? _WideLayout(project: project) : _NarrowLayout(project: project),
        ),
      ),
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
        ProjectImage(assetPath: project.imageAsset, width: 150, height: 120),
        const SizedBox(width: 16),
        Expanded(child: ProjectInfo(project: project)),
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
        Center(child: ProjectImage(assetPath: project.imageAsset, height: 150)),
        const SizedBox(height: 12),
        ProjectInfo(project: project),
      ],
    );
  }
}
