// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';

class AppLifecycleTest extends StatefulWidget {
  static String routeName = "routeNameForAppLifeCycleTest";
  const AppLifecycleTest({super.key});

  @override
  State<AppLifecycleTest> createState() => _AppLifecycleTestState();
}

class _AppLifecycleTestState extends State<AppLifecycleTest> with WidgetsBindingObserver {
  late final Timer _timer;
  late int count;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    count = 0;
    _startTimer();
  }

  @override
  void dispose() {
    _endTiemr();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        count = _timer.tick;
      });
      print(count);
    });
  }

  void _endTiemr() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "App LifeCycle",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count.toString()),
            ElevatedButton(
              onPressed: () {
                _endTiemr();
              },
              child: Text("타이머 정지"),
            ),
          ],
        ),
      ),
    );
  }

//method

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //https://api.flutter.dev/flutter/dart-ui/AppLifecycleState-class.html
    switch (state) {
      case AppLifecycleState.resumed:
        // 앱이 표시되고 사용자 입력에 응답합니다.
        // 주의! 최초 앱 실행때는 해당 이벤트가 발생하지 않습니다.
        print("resumed");
        break;
      case AppLifecycleState.inactive:
        // 앱이 비활성화 상태이고 사용자의 입력을 받지 않습니다.
        // ios에서는 포 그라운드 비활성 상태에서 실행되는 앱 또는 Flutter 호스트 뷰에 해당합니다.
        // 안드로이드에서는 화면 분할 앱, 전화 통화, PIP 앱, 시스템 대화 상자 또는 다른 창과 같은 다른 활동이 집중되면 앱이이 상태로 전환됩니다.
        // inactive가 발생되고 얼마후 pasued가 발생합니다.
        print("inactive");
        break;
      case AppLifecycleState.paused:
        // 앱이 현재 사용자에게 보이지 않고, 사용자의 입력을 받지 않으며, 백그라운드에서 동작 중입니다.
        // 안드로이드의 onPause()와 동일합니다.
        // 응용 프로그램이 이 상태에 있으면 엔진은 Window.onBeginFrame 및 Window.onDrawFrame 콜백을 호출하지 않습니다.
        print("paused");
        break;
      case AppLifecycleState.detached:
        // 응용 프로그램은 여전히 flutter 엔진에서 호스팅되지만 "호스트 View"에서 분리됩니다.
        // 앱이 이 상태에 있으면 엔진이 "View"없이 실행됩니다.
        // 엔진이 처음 초기화 될 때 "View" 연결 진행 중이거나 네비게이터 팝으로 인해 "View"가 파괴 된 후 일 수 있습니다.
        print("detached");
        break;
      case AppLifecycleState.hidden:
        print("hidden?");
        break;
    }
  } //did changeAppLifeCycle
}//end class
