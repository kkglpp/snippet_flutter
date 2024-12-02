import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/custom/custom_elebtn.dart';
import 'package:snippet_flutter_app/const/custom/custom_text.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:snippet_flutter_app/func_test/view/app_lifecycle_test.dart';
import 'package:snippet_flutter_app/sample_widget/animationContainer/animation_container_test.dart';

class Home extends StatelessWidget {
  static String routeName = 'routeNameForHome';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth - 40;
      double maxHeight = constraints.maxWidth - 40;

      return DefaultLayout(
        title: "각 파트로 이동",
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(txt: "기능 테스트"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomElebtn(
                    txt: "AppLifeCycle\nTestPage",
                    width: 120,
                    height: 40,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppLifecycleTest(),
                      ),
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                color: Colors.green[900],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(txt: "sample Widget"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: maxHeight * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomElebtn(
                            txt: "Animation\nContianer",
                            width: 120,
                            height: 40,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AnimationContainerTest(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
