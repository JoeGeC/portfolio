import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.sizeOf(context).width > 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Profile section
              const CircleAvatar(
                radius: 75,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Joe Barker',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Native Android & Flutter Developer',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),

              // Links
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _LinkChip(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: () => _launch('https://github.com/joegec'),
                  ),
                  _LinkChip(
                    icon: Icons.work,
                    label: 'LinkedIn',
                    onTap: () => _launch(
                        'https://linkedin.com/in/joe-barker-mobile-developer'),
                  ),
                  _LinkChip(
                    icon: Icons.email,
                    label: 'Contact Me',
                    onTap: () => _launch('mailto:joe.joeb29@gmail.com'),
                  ),
                  ActionChip(
                    avatar: const Icon(Icons.download, size: 18),
                    label: const Text('Download CV'),
                    onPressed: () => _launch('Joe_Barker_CV.pdf'),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Featured Projects heading
              Row(
                children: [
                  Text(
                    'Featured Projects',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => context.go('/projects'),
                    child: const Text('View All →'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Project cards
              ...Project.all.map(
                (project) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ProjectCard(project: project, isWide: isWide),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launch(String url) => _launchUrl(url);
}

class _LinkChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _LinkChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final bool isWide;

  const _ProjectCard({required this.project, required this.isWide});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _launchUrl(project.readmePageUrl),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        project.imageAsset,
                        width: 150,
                        height: 120,
                        fit: BoxFit.contain,
                        errorBuilder: (_, e, st) => Container(
                          width: 150,
                          height: 120,
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(Icons.code,
                              size: 48, color: theme.colorScheme.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: _ProjectInfo(project: project)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          project.imageAsset,
                          height: 150,
                          fit: BoxFit.contain,
                          errorBuilder: (_, e, st) => Container(
                            height: 150,
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: Icon(Icons.code,
                                size: 48, color: theme.colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ProjectInfo(project: project),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  final Project project;

  const _ProjectInfo({required this.project});

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
        Text(
          project.description,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.technologies
              .map((tech) => Chip(
                    label: Text(tech, style: const TextStyle(fontSize: 12)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
