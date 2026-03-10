class BlogPost {
  final String title;
  final String slug;
  final DateTime date;
  final String excerpt;

  const BlogPost({
    required this.title,
    required this.slug,
    required this.date,
    required this.excerpt,
  });

  String get assetPath => 'assets/blog/$slug.md';

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      title: json['title'] as String,
      slug: json['slug'] as String,
      date: DateTime.parse(json['date'] as String),
      excerpt: json['excerpt'] as String,
    );
  }
}
