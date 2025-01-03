import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/custom/custom_elebtn.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:snippet_flutter_app/sample_widget/health_kit/health_kit_active.dart';

class HealthKitScreen extends StatefulWidget {
  const HealthKitScreen({super.key});

  @override
  State<HealthKitScreen> createState() => _HealthKitScreenState();
}

class _HealthKitScreenState extends State<HealthKitScreen> {
  late String text;
  @override
  void initState() {
    super.initState();
    text = "Health Kit Lib 테스트";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: text,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text + "\n 권한 설정 페이지"),
            SizedBox(
              height: 100,
            ),
            CustomElebtn(
              txt: "실행 화면\nTestPage",
              width: 120,
              height: 40,
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HealthKitActive())),
            ),
          ],
        ),
      ),
    );
  }
}
