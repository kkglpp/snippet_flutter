import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snippet_flutter_app/const/page_router/navigator_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter가 위젯을 빌드하기 전에 초기화 작업을 수행하도록 함

  runApp(
    const ProviderScope(
      // RiverPod을 사용하기 위해서는 가장 첫 my app을 실행할떄 providerScope 로 감쌓야한다.
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      // Gorouter 를 사용하기 위해서 materialApp 에 router를 확장? 한다.
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,

      //그 외 기본 app 셋팅 부분
      debugShowCheckedModeBanner: false,
      title: 'snippet app for Flutter func & widget test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
