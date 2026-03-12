import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../blog/blog_loader.dart';
import '../blog/blog_post.dart';
import '../l10n/l10n.dart';
import '../widgets/blog_post_card.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late final Future<List<BlogPost>> _postsFuture = BlogLoader.loadIndex();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppLayout.pagePaddingH,
        vertical: AppLayout.pagePaddingV,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppLayout.contentMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PageHeader(),
              const SizedBox(height: 24),
              _PostsList(postsFuture: _postsFuture),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.blog,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.blogSubtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class _PostsList extends StatelessWidget {
  final Future<List<BlogPost>> postsFuture;

  const _PostsList({required this.postsFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogPost>>(
      future: postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              context.l10n.errorLoadingPosts(snapshot.error.toString()),
            ),
          );
        }
        final posts = snapshot.data!;
        return posts.isEmpty
            ? _EmptyState()
            : _PostsColumn(posts: posts);
      },
    );
  }
}

class _PostsColumn extends StatelessWidget {
  final List<BlogPost> posts;

  const _PostsColumn({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: posts
          .map((post) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BlogPostCard(post: post),
              ))
          .toList(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.article_outlined,
              size: 64,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.noBlogPosts,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
