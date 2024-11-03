import 'package:flutter/material.dart';

/// WigetBindingObserver를 적용하는 페이지

class BaseLayout extends StatelessWidget  with WidgetsBindingObserver{
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