import 'package:flutter/material.dart';
import 'package:pedometer_2/pedometer_2.dart' as pedo2;
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  pedo2.Pedometer pedo_02 = pedo2.Pedometer();
  Pedometer pedo_01 = Pedometer();

  late int pedo01_count;
  late int pedo02_count;
  late bool isPermissioned;

  @override
  void initState() {
    super.initState();
    pedo01_count = 0;
    pedo02_count = 0;
    isPermissioned = false;
    checkItPermissioned;
  }

  checkItPermissioned() async {
    isPermissioned = await Permission.activityRecognition.isGranted;
    setState(() {});
  }

  updatePedo2() async {
    pedo02_count = await pedo_02.getStepCount();
    setState(() {});
  }

  setPedo1() async {}

  getPermissioned() async {
    print("isperMissioned in start Method : $isPermissioned");
    isPermissioned = await Permission.activityRecognition.request().isGranted;
    print("isperMissioned in end Method : $isPermissioned");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.amber[100],
              width: 400,
              height: 100,
              child: Text("권한 상태 : ${isPermissioned}"),
            ),
            ElevatedButton(
              onPressed: () {
                getPermissioned();
              },
              child: Text("Pedometer 권한 요청"),
            ),
            Divider(),
            Container(
              color: Colors.amber[100],
              width: 400,
              height: 200,
              child: Text("일반 pedometer : ${pedo01_count} 걸음"),
            ),
            Divider(),
            Container(
              width: 400,
              height: 200,
              child: Text("pedometer2 : $pedo02_count 걸음"),
            ),
            ElevatedButton(
              onPressed: () {
                updatePedo2();
              },
              child: Text("Pedometer2 갱신"),
            ),
          ],
        ),
      ),
    );
  }
}
