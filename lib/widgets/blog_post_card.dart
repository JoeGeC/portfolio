import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../blog/blog_post.dart';
import '../l10n/l10n.dart';
import 'post_date_row.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPost post;

  const BlogPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('${AppRoutes.blog}/${post.slug}'),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostDateRow(formattedDate: post.formattedDate),
              const SizedBox(height: 8),
              Text(
                post.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post.excerpt,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 12),
              _ReadMoreLink(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadMoreLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(Icons.arrow_forward, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(
          context.l10n.readMore,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
