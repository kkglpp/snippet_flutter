import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snippet_flutter_app/const/page_router/route_for_func_test.dart';
import 'package:snippet_flutter_app/const/page_router/routes_for_widget_test.dart';
import 'package:snippet_flutter_app/home.dart';

// final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

// 오란인혹은 보안 설정까지 넣기 위해서 provider/notifier로 Navigator 를 설정한다.
final routerProvider = Provider<GoRouter>(
  (ref) {
    final navigatorProvider = NavigatorNotifier();
    return GoRouter(
      initialLocation: '/',
      routes: navigatorProvider._routes,
    );
  },
);

class NavigatorNotifier extends ChangeNotifier with RouteForFuncTest, RoutesForWidgetTest {
  NavigatorNotifier();
  List<GoRoute> get _routes => [
        //기본 Root 경로는 여기서 만들자.
        GoRoute(
          path: "/",
          name: Home.routeName,
          builder: (context, state) => const Home(),
          routes: [
            ...funcTestRouteList,
            ...widgetTestRouteList,
          ],
        )
      ];
} //end RouterSetting
