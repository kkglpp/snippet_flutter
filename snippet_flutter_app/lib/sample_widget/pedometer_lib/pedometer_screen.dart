import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snippet_flutter_app/const/custom/custom_elebtn.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:pedometer/pedometer.dart';
import 'package:snippet_flutter_app/sample_widget/pedometer_lib/count_step_screen.dart';

class PedometerScreen extends StatefulWidget {
  const PedometerScreen({super.key});

  @override
  State<PedometerScreen> createState() => _PedometerScreenState();
}

class _PedometerScreenState extends State<PedometerScreen> {
  // Field
  late int myStep;
  late StreamSubscription<StepCount> _stepCountStream;

  //upward Method :
  void initState() {
    super.initState();
    myStep = 0;
    _requestActivityRecognitionPermission();
  }

  Future<void> _requestActivityRecognitionPermission() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      var result = await Permission.activityRecognition.request();
      // _handlePermissionStatus(result);
    }
  }

  // void _handlePermissionStatus(PermissionStatus status) {
  //   if (status.isGranted) {
  //     // 권한이 허용된 경우
  //     print("Permission granted");
  //   } else {
  //     if (status.isPermanentlyDenied) {
  //       // '다시 묻지 않기' 선택 후 거부
  //       _showSettingsDialog();
  //     } else {
  //       // 일반 거부
  //       _showPermissionDialog();
  //     }
  //   }
  // }

  // void _showSettingsDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("권한 필요"),
  //       content: const Text("이 앱은 활동 인식 권한이 필요합니다. 설정에서 권한을 허용해주세요."),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text("설정으로 이동"),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             openAppSettings();
  //           },
  //         ),
  //         TextButton(
  //           child: const Text("취소"),
  //           onPressed: () => Navigator.of(context).pop(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _showPermissionDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("권한 필요"),
  //       content: const Text("이 앱은 활동 인식 권한이 필요합니다. 권한을 허용해주세요."),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text("허용"),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             _requestActivityRecognitionPermission(); // 권한 요청 다시 시도
  //           },
  //         ),
  //         TextButton(
  //           child: const Text("취소"),
  //           onPressed: () => Navigator.of(context).pop(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

// end UpWard Method

// start Widgt Build :
  @override
  Widget build(BuildContext context) {
    String titleText = "만보기 테스트 : peometer 라이브러리 권한 실행";
    return DefaultLayout(
      title: titleText,
      body: Center(
        child: Column(
          children: [
            Text(titleText),
            CustomElebtn(
              txt: "만보기 테스트",
              width: 120,
              height: 40,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CountStepScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
