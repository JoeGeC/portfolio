import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';

class ProjectDetailPage extends StatefulWidget {
  final String repo;

  const ProjectDetailPage({super.key, required this.repo});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  String? _markdown;
  bool _loading = true;
  String? _error;
  Project? _project;

  @override
  void initState() {
    super.initState();
    _project = Project.all.where((p) => p.repo == widget.repo).firstOrNull;
    _fetchReadme();
  }

  Future<void> _fetchReadme() async {
    try {
      // Try main branch first, then master
      final mainUrl =
          'https://raw.githubusercontent.com/joegec/${widget.repo}/main/README.md';
      var response = await http.get(Uri.parse(mainUrl));

      if (response.statusCode != 200) {
        final masterUrl =
            'https://raw.githubusercontent.com/joegec/${widget.repo}/master/README.md';
        response = await http.get(Uri.parse(masterUrl));
      }

      if (response.statusCode == 200) {
        setState(() {
          _markdown = response.body;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Could not load README (${response.statusCode})';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load README: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and title
              if (_project != null) ...[
                Text(
                  _project!.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _project!.technologies
                      .map((tech) => Chip(
                            label: Text(tech,
                                style: const TextStyle(fontSize: 12)),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(_project!.githubUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('View on GitHub'),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
              ],

              // README content
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_error != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      children: [
                        Icon(Icons.error_outline,
                            size: 48,
                            color: theme.colorScheme.error),
                        const SizedBox(height: 16),
                        Text(_error!,
                            style: TextStyle(color: theme.colorScheme.error)),
                      ],
                    ),
                  ),
                )
              else
                MarkdownBody(
                  data: _markdown!,
                  selectable: true,
                  onTapLink: (text, href, title) async {
                    if (href != null) {
                      final uri = Uri.parse(href);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      }
                    }
                  },
                  // Corrected sizedImageBuilder signature
                  sizedImageBuilder: (config) {
                    String imageUrl = config.uri.toString();
                    if (!imageUrl.startsWith('http')) {
                      imageUrl =
                          'https://raw.githubusercontent.com/joegec/${widget.repo}/main/$imageUrl';
                    }
                    return Image.network(
                      imageUrl,
                      width: config.width,
                      height: config.height,
                      errorBuilder: (_, e, st) => const SizedBox.shrink(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
