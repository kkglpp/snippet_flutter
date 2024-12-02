//아래에서 설정한 routes 들에 접근하는 함수
import 'package:go_router/go_router.dart';
import 'package:snippet_flutter_app/sample_widget/animationContainer/animation_container_test.dart';

mixin class RoutesForWidgetTest {
  List<GoRoute> widgetTestRouteList = [
    GoRoute(
      path: "AnimationContainerTest",
      name: AnimationContainerTest.routeName,
      builder: (context, state) => const AnimationContainerTest(),
    ),
  ];
}
