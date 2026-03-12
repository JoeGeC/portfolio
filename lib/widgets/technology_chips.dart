import 'package:flutter/material.dart';

class TechnologyChips extends StatelessWidget {
  final List<String> technologies;

  const TechnologyChips({super.key, required this.technologies});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: technologies
          .map((tech) => Chip(
                label: Text(tech, style: const TextStyle(fontSize: 12)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ))
          .toList(),
    );
  }
}
