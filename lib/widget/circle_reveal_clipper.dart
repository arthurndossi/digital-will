import 'package:flutter/cupertino.dart';

class CircleRevealClipper extends CustomClipper<Rect> {
  CircleRevealClipper();

  @override
  Rect getClip(Size size) {
    final epicenter = new Offset(size.width, size.height);
    final distanceToCorner = epicenter.dy;
    final radius = distanceToCorner;
    final diameter = radius;

    return new Rect.fromLTWH(epicenter.dx - radius - 2, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}