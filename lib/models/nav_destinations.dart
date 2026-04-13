import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../app_constants.dart';
import '../feature_flags.dart';
import 'nav_item.dart';

List<NavItem> navDestinations(AppLocalizations l10n) => [
      NavItem(label: l10n.home, path: AppRoutes.home, icon: Icons.home),
      NavItem(label: l10n.projects, path: AppRoutes.projects, icon: Icons.code),
      if (FeatureFlags.blogEnabled)
        NavItem(label: l10n.blog, path: AppRoutes.blog, icon: Icons.article),
    ];
