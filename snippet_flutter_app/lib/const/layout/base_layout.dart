import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  const BaseLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: body,
    );
  }
}