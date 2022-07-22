import 'package:flutter/material.dart';

class ChatBubble extends CustomPainter {
  late Color color;

  ChatBubble({
    required this.color,
  });

  var _radius = 10.0;
  var _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          _x,
          0,
          size.width,
          size.height,
          bottomRight: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
          topLeft: Radius.circular(_radius),
        ),
        Paint()
          ..color = this.color
          ..style = PaintingStyle.fill);
    var path = new Path();
    path.moveTo(0, size.height);
    path.lineTo(_x, size.height);
    path.lineTo(_x, size.height - 20);
    canvas.clipPath(path);
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          0,
          0.0,
          _x,
          size.height,
          topRight: Radius.circular(_radius),
        ),
        Paint()
          ..color = this.color
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
