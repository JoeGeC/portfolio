import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_constants.dart';
import 'feature_flags.dart';
import 'scaffold_with_nav.dart';
import 'pages/home_page.dart';
import 'pages/projects_page.dart';
import 'pages/blog_page.dart';
import 'pages/blog_post_page.dart';

GoRouter buildRouter({
  required VoidCallback onToggleTheme,
  required ValueGetter<bool> isDarkMode,
}) => GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithNav(
        onToggleTheme: onToggleTheme,
        isDarkMode: isDarkMode(),
        child: child,
      ),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: AppRoutes.projects,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProjectsPage()),
        ),
        if (FeatureFlags.blogEnabled)
          GoRoute(
            path: AppRoutes.blog,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: BlogPage()),
            routes: [
              GoRoute(
                path: AppRoutes.blogPostSlug,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: BlogPostPage(
                    slug: state.pathParameters[AppRoutes.slugParam]!,
                  ),
                ),
              ),
            ],
          ),
      ],
    ),
  ],
);
