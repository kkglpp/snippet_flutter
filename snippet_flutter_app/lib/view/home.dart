import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:snippet_flutter_app/view/app_lifecycle_test.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "각 파트로 이동",
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppLifecycleTest(),
                    ),
                  ),
                  child: const Text("AppLifeCycle TestPage"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
