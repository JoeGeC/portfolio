import '../app_constants.dart';

class BlogPost {
  final String title;
  final String slug;
  final DateTime date;
  final String excerpt;
  final bool sticky;

  const BlogPost({
    required this.title,
    required this.slug,
    required this.date,
    required this.excerpt,
    this.sticky = false,
  });

  String get assetPath => '${AppAssets.blogAssetPrefix}$slug.md';

  String get formattedDate =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
        title: json['title'] as String,
        slug: json['slug'] as String,
        date: DateTime.parse(json['date'] as String),
        excerpt: json['excerpt'] as String,
        sticky: json['sticky'] as bool? ?? false,
      );
}
