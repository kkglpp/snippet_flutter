import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';

class CountStepScreen extends StatefulWidget {
  const CountStepScreen({super.key});

  @override
  State<CountStepScreen> createState() => _CountStepScreenState();
}

class _CountStepScreenState extends State<CountStepScreen> {
  // Field
  late int myStep;
  late DateTime lastRecordTime;
  late StreamSubscription<StepCount> _stepCountStream;

  //upward Method :
  void initState() {
    super.initState();
    myStep = 0;
    lastRecordTime = DateTime.now();
    _initPedometer();
  }

  @override
  void dispose() {
    _stepCountStream.cancel();
    super.dispose();
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
      onDone: () => print("스트림 종료"),
    );
    print("스트림 시작");
  }

  void _onStepCount(StepCount event) {
    setState(() {
      myStep = event.steps;
      lastRecordTime = event.timeStamp;
      print("event에 의해서 작동 ");
      print("${_stepCountStream.toString()}");
    });
  }

  void _onStepCountError(dynamic error) {
    print("Step Count Error: $error");
  }

  @override
  Widget build(BuildContext context) {
    String titleText = "만보기 테스트 : 걸음 수 카운트 하기";

    return DefaultLayout(
      title: titleText,
      body: Center(
        child: Column(
          children: [
            Text(myStep.toString() + " 걸음"),
            SizedBox(height: 20),
            Text("마지막 걸음 시간"),
            Text(lastRecordTime.toString())
          ],
        ),
      ),
    );
  }
}
