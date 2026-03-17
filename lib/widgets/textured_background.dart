import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TexturedBackground extends StatelessWidget {
  const TexturedBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RepaintBoundary(
      child: CustomPaint(
        painter: _DotGridPainter(isDark: isDark),
        child: RepaintBoundary(child: child),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  _DotGridPainter({required this.isDark});

  final bool isDark;

  static const double _spacing = 5;
  static const double _radius = 1.6;

  Float32List? _cachedPoints;
  Size? _cachedSize;

  Float32List _buildPoints(Size size) {
    final cols = (size.width / _spacing).ceil();
    final rows = (size.height / _spacing).ceil();
    final buffer = Float32List(cols * rows * 2);
    var i = 0;
    for (double x = _spacing / 2; x < size.width; x += _spacing) {
      for (double y = _spacing / 2; y < size.height; y += _spacing) {
        buffer[i++] = x;
        buffer[i++] = y;
      }
    }
    return i == buffer.length ? buffer : buffer.sublist(0, i);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_cachedPoints == null || _cachedSize != size) {
      _cachedSize = size;
      _cachedPoints = _buildPoints(size);
    }

    final paint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.09)
      ..strokeWidth = _radius * 2
      ..strokeCap = StrokeCap.round;

    canvas.drawRawPoints(ui.PointMode.points, _cachedPoints!, paint);
  }

  @override
  bool shouldRepaint(_DotGridPainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}
