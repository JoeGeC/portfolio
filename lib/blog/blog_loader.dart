import 'dart:convert';
import 'package:flutter/services.dart';
import '../app_constants.dart';
import 'blog_post.dart';

class BlogLoader {
  static Future<List<BlogPost>> loadIndex() async {
    final jsonString = await rootBundle.loadString(AppAssets.blogIndexJson);
    final List<dynamic> jsonList = json.decode(jsonString);
    final posts = jsonList
        .map((e) => BlogPost.fromJson(e as Map<String, dynamic>))
        .toList();
    posts.sort((a, b) => b.date.compareTo(a.date));
    return posts;
  }

  static Future<String> loadContent(BlogPost post) =>
      rootBundle.loadString(post.assetPath);
}
