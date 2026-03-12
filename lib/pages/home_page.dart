import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../l10n/l10n.dart';
import '../models/project.dart';
import '../utils/url_launcher_utils.dart';
import '../widgets/link_chip.dart';
import '../widgets/project_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppLayout.pagePaddingH,
        vertical: AppLayout.pagePaddingV,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.contentMaxWidth),
          child: Column(
            children: [
              _ProfileSection(),
              const SizedBox(height: 24),
              _LinkChipsRow(),
              const SizedBox(height: 48),
              _FeaturedProjectsHeader(),
              const SizedBox(height: 16),
              ..._projectCards,
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get _projectCards => Project.all
      .map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ProjectCard(project: p),
          ))
      .toList();
}

class _ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const CircleAvatar(
          radius: 75,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage(AppAssets.profilePicture),
          child: Icon(Icons.person, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          context.l10n.ownerName,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.jobTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class _LinkChipsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        LinkChip(
          icon: Icons.code,
          label: l10n.github,
          onTap: () => launchExternalUrl(AppUrls.github),
        ),
        LinkChip(
          icon: Icons.work,
          label: l10n.linkedIn,
          onTap: () => launchExternalUrl(AppUrls.linkedIn),
        ),
        LinkChip(
          icon: Icons.email,
          label: l10n.contactMe,
          onTap: () => launchExternalUrl(AppUrls.email),
        ),
        ActionChip(
          avatar: const Icon(Icons.download, size: 18),
          label: Text(l10n.downloadCv),
          onPressed: () => launchExternalUrl(AppUrls.cv),
        ),
      ],
    );
  }
}

class _FeaturedProjectsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.l10n.featuredProjects,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => context.go(AppRoutes.projects),
          child: Text(context.l10n.viewAll),
        ),
      ],
    );
  }
}
