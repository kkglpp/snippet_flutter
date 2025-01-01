import 'package:flutter/material.dart';

class SimpleCircle extends StatelessWidget {
  final GlobalKey boxKey;
  final double boxSize;
  const SimpleCircle({super.key, required this.boxKey, required this.boxSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: boxKey,
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(1),
      ),
    );
  }
}
