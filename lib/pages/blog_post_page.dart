import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../app_constants.dart';
import '../blog/blog_loader.dart';
import '../blog/blog_post.dart';
import '../l10n/l10n.dart';
import '../utils/url_launcher_utils.dart';
import '../widgets/post_date_row.dart';
import '../widgets/post_error_view.dart';

class BlogPostPage extends StatefulWidget {
  final String slug;

  const BlogPostPage({super.key, required this.slug});

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  String? _markdown;
  BlogPost? _post;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    final l10n = context.l10n;
    try {
      final posts = await BlogLoader.loadIndex();
      final post = posts.where((p) => p.slug == widget.slug).firstOrNull;
      if (post == null) {
        _setError(l10n.postNotFound);
        return;
      }
      final content = await BlogLoader.loadContent(post);
      setState(() {
        _post = post;
        _markdown = content;
        _loading = false;
      });
    } catch (e) {
      _setError(l10n.failedToLoadPost(e.toString()));
    }
  }

  void _setError(String message) =>
      setState(() { _error = message; _loading = false; });

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return PostErrorView(message: _error!);

    return _PostContent(post: _post!, markdown: _markdown!);
  }
}

class _PostContent extends StatelessWidget {
  final BlogPost post;
  final String markdown;

  const _PostContent({required this.post, required this.markdown});

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
      ),
    );
  }
}
