import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final GlobalKey? gbKey;
  final Color? clr;
  const LocationCard({super.key, this.gbKey, this.clr});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: gbKey,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: clr ?? (gbKey == null ? Colors.green[200] : Colors.purple[200]),
      ),
    );
  }
}
