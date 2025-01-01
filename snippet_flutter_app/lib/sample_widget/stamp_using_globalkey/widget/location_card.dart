import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final GlobalKey? gbKey;
  final Color? clr;
  final double boxSize;
  const LocationCard({super.key, this.gbKey, this.clr, required this.boxSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: gbKey,
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: clr ?? (gbKey == null ? Colors.green[200] : Colors.purple[200]),
      ),
    );
  }
}
