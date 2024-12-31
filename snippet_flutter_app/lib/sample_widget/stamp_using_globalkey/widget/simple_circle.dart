import 'package:flutter/material.dart';

class SimpleCircle extends StatelessWidget {
  const SimpleCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }
}
