import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snippet_flutter_app/const/page_router/navigator_notifier.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter가 위젯을 빌드하기 전에 초기화 작업을 수행하도록 함
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // // 주기적인 작업 등록
  // Workmanager().registerPeriodicTask(
  //   "sendStep",
  //   "readStepCount",
  //   frequency: const Duration(minutes: 15), // 최소 15분 이상의 주기로 설정
  // );

  runApp(
    const ProviderScope(
      // RiverPod을 사용하기 위해서는 가장 첫 my app을 실행할때 ProviderScope로 감쌀 필요가 있음
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      // GoRouter를 사용하기 위해서 MaterialApp에 router 설정 추가
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,

      // 그 외 기본 app 셋팅
      debugShowCheckedModeBanner: false,
      title: 'snippet app for Flutter func & widget test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

// 백그라운드에서 호출될 callbackDispatcher 함수
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    int myStep = 0;
    switch (task) {
      case "readStepCount":
        for (int i = 0; i < 10; i++) {
          await Future.delayed(Duration(seconds: 1));
          print("$i 초 지남");
        }

      // print("걸음 수: $myStep");
      // print("백그라운드 작업 실행 시간: ${DateTime.now()}");
      // break;
      default:
        print("unKnown task");
    }
    return Future.value(true);
  });
}
