import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snippet_flutter_app/func_test/app_life_cycle/app_lifecycle_test.dart';

// 아래에서 만든 route들에 이동하는 함수들을 넣는 class
mixin class RouteForFuncTest {
  void pushToAppLifeCycleTest(BuildContext ctx) async {
    await ctx.pushNamed(AppLifecycleTest.routeName);
  }

  List<GoRoute> funcTestRouteList = [
    GoRoute(
      path: "appLifeCycleTest",
      name: AppLifecycleTest.routeName,
      builder: (context, state) => const AppLifecycleTest(),
    ),

  ];
}
