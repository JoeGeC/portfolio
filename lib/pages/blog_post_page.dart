import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../app_constants.dart';
import '../blog/blog_loader.dart';
import '../blog/blog_post.dart';
import '../l10n/l10n.dart';
import '../utils/url_launcher_utils.dart';
import '../widgets/content_panel.dart';
import '../widgets/post_date_row.dart';
import '../widgets/post_error_view.dart';

class BlogPostPage extends StatefulWidget {
  final String slug;

  const BlogPostPage({super.key, required this.slug});

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  BlogPost? _post;
  String? _markdown;
  bool _loading = true;
  bool _notFound = false;
  Object? _exception;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    try {
      final posts = await BlogLoader.loadIndex();
      if (!mounted) return;
      final post = posts.where((p) => p.slug == widget.slug).firstOrNull;
      if (post == null) {
        setState(() { _notFound = true; _loading = false; });
        return;
      }
      final content = await BlogLoader.loadContent(post);
      if (!mounted) return;
      setState(() { _post = post; _markdown = content; _loading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() { _exception = e; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_notFound) return PostErrorView(message: context.l10n.postNotFound);
    if (_exception != null) {
      return PostErrorView(message: context.l10n.failedToLoadPost(_exception.toString()));
    }
    return _PostContent(post: _post!, markdown: _markdown!);
  }
}

class _PostContent extends StatelessWidget {
  final BlogPost post;
  final String markdown;

  const _PostContent({required this.post, required this.markdown});

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
              PostDateRow(formattedDate: post.formattedDate),
              const SizedBox(height: 24),
              MarkdownBody(
                data: markdown,
                selectable: true,
                onTapLink: (linkText, href, linkTitle) =>
                    href != null ? launchExternalUrl(href) : null,
              ),
            ],
          ),
        ),
      );
}
