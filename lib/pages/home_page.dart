import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../blog/blog_loader.dart';
import '../blog/blog_post.dart';
import '../l10n/l10n.dart';
import '../models/project.dart';
import '../utils/url_launcher_utils.dart';
import '../widgets/blog_post_card.dart';
import '../widgets/content_panel.dart';
import '../widgets/link_chip.dart';
import '../widgets/project_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.pagePaddingH,
          vertical: AppLayout.pagePaddingV,
        ),
        child: ContentPanel(
          child: Column(
            children: [
              _ProfileSection(),
              const SizedBox(height: 24),
              _LinkChipsRow(),
              const SizedBox(height: 48),
              _FeaturedProjectsHeader(),
              const SizedBox(height: 16),
              ..._projectCards,
              const SizedBox(height: 48),
              _LatestPostsSection(),
            ],
          ),
        ),
      );

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
      ],
    );
  }
}

class _FeaturedProjectsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
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

class _LatestPostsSection extends StatefulWidget {
  @override
  State<_LatestPostsSection> createState() => _LatestPostsSectionState();
}

class _LatestPostsSectionState extends State<_LatestPostsSection> {
  late final Future<List<BlogPost>> _postsFuture = BlogLoader.loadIndex();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LatestPostsHeader(),
          const SizedBox(height: 16),
          _LatestPostsFeed(postsFuture: _postsFuture),
        ],
      );
}

class _LatestPostsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(
            context.l10n.latestPosts,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => context.go(AppRoutes.blog),
            child: Text(context.l10n.viewAll),
          ),
        ],
      );
}

class _LatestPostsFeed extends StatelessWidget {
  final Future<List<BlogPost>> postsFuture;

  const _LatestPostsFeed({required this.postsFuture});

  @override
  Widget build(BuildContext context) => FutureBuilder<List<BlogPost>>(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const SizedBox.shrink();
          }
          return _LatestPostsCards(
            posts: snapshot.data!.take(AppLayout.latestPostsCount).toList(),
          );
        },
      );
}

class _LatestPostsCards extends StatelessWidget {
  final List<BlogPost> posts;

  const _LatestPostsCards({required this.posts});

  @override
  Widget build(BuildContext context) => Column(
        children: posts
            .map(
              (post) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: BlogPostCard(post: post),
              ),
            )
            .toList(),
      );
}
