import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedCustomPainter extends CustomPainter {
  Paint _paint = Paint();
  final Animation<double> _sweep;
  final Animation _color;

  AnimatedCustomPainter(AnimationController controller)
      : _sweep = Tween<double>(begin: 0, end: 2 * pi).animate(controller),
        _color = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller),
        super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = _color.value;

    canvas.drawArc(
      Rect.fromPoints(Offset(50, 50), Offset(250, 250)),
      -pi / 2,
      _sweep.value,
      true,
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
