// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:health/health.dart';

class HealthKitActive extends StatefulWidget {
  const HealthKitActive({super.key});

  @override
  State<HealthKitActive> createState() => _HealthKitActiveState();
}

class _HealthKitActiveState extends State<HealthKitActive> {
  late String text;
  late bool granted;
  late int repteated;
  late int? stepAmount;
  var types = [
    // HealthDataType.HEART_RATE,
    HealthDataType.STEPS,
  ];
  var permissions = [
    HealthDataAccess.READ_WRITE,
  ];
  late List<HealthDataPoint> healthData;

  @override
  void initState() {
    super.initState();
    Health().configure();
    text = "Health Kit Lib 테스트";
    healthData = [];
    granted = false;
    repteated = 0;
    healthData = [];
    _requestHealthPermissioned();
    stepAmount = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<void> _requestHealthPermissioned() async {
    var permissionStatus = await Permission.activityRecognition.status;
    // var permissionStatus = await Health().requestAuthorization(types);
    print("_requestHealthPermission 함수에서 status  - > $permissionStatus ");
    print(permissionStatus);
    if (permissionStatus.isGranted) {
      var requestSuccess = await Health().requestAuthorization(types, permissions: permissions);
      if (requestSuccess) {
        granted = true;
        await getHealthData();
      }
      setState(() {});
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> getStepAmount() async {
    stepAmount = await Health().getTotalStepsInInterval(DateTime.now().subtract(Duration(days: 1)), DateTime.now());
    setState(() {});
  }

  getHealthData() async {
    print("get 헬스 데이터 시작");
    healthData = await Health().getHealthDataFromTypes(
        types: types, startTime: DateTime.now().subtract(const Duration(hours: 1)), endTime: DateTime.now());
    // getHealthDataFromTypes(now.subtract(Duration(days: 1)), now, types);
    setState(() {});
  }

  /* 권한 신청을 위한 다이얼로그를 위한 함수들 */

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("권한 필요"),
        content: const Text("이 앱은 활동 인식 권한이 필요합니다. 권한을 허용해주세요."),
        actions: <Widget>[
          TextButton(
            child: const Text("허용"),
            onPressed: () async {
              print("*" * 40);
              bool requestSuccess = false;
              try {
                // var temp = await Permission.activityRecognition.request();
                // print("activityRecognition : ${temp.isGranted}");
                requestSuccess = await Health().requestAuthorization(types, permissions: permissions);
                print("requestSuccess : $requestSuccess");
              } catch (e) {
                print("erro 발생 : $e");
              }
              print("권한승인 성공? : $requestSuccess");

              Navigator.of(context).pop();
              // _requestHealthPermissioned(); // 권한 요청 다시 시도
            },
          ),
          TextButton(
            child: const Text("취소"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: text,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(height: 50),
            Text(healthData.toString()),
            const SizedBox(height: 50),
            Text("granted  :  $granted"),
            const SizedBox(height: 50),
            Text("step  :  $stepAmount")
          ],
        ),
      ),
    );
  }
}
