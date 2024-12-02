import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:snippet_flutter_app/sample_widget/animationContainer/animation_container_notifier.dart';

class AnimationContainerTest extends ConsumerStatefulWidget {
  static String routeName = "routeForAnimationContainerTest";
  const AnimationContainerTest({super.key});

  @override
  ConsumerState<AnimationContainerTest> createState() => _AnimationContainerTestState();
}

class _AnimationContainerTestState extends ConsumerState<AnimationContainerTest> {
  late double width;

  @override
  void initState() {
    super.initState();
    width = 100;
  }

  @override
  Widget build(BuildContext context) {
    // final vm = ref.watch(animationContainerProvider);
    return DefaultLayout(
        title: "애니메이션 컨테이너 기본형태",
        body: Center(
          child: SafeArea(
            left: true,
            right: true,
            bottom: true,
            top: true,
            minimum: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer(builder: (context, ref, child) {
                  print("첫번째 박스 랜더링");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        width: ref.read(animationContainerProvider.notifier).firstWidth,
                        height: 80,
                        duration: const Duration(milliseconds: 500),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            ref.read(animationContainerProvider.notifier).extensionFirstWidthInProvider(20);
                            // if (width < 200) {
                            //   width += 20;
                            // }
                          },
                          child: const Text('CLICK')),
                    ],
                  );
                }),
                Consumer(builder: (context, ref, child) {
                  final secondWidth = ref.watch(animationContainerProvider.select((state) => state.secondWidth));
                  print("두번째 박스 랜더링");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        width: secondWidth,
                        height: 80,
                        duration: const Duration(milliseconds: 500),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            ref.read(animationContainerProvider.notifier).extensionSecondWidthInProvider(20);
                            // if (width < 200) {
                            //   width += 20;
                            // }
                          },
                          child: const Text('CLICK')),
                    ],
                  );
                }),
                Consumer(builder: (context, ref, child) {
                  print("세번쨰 박스 랜더링");
                  final thirdState = ref.watch(animationContainerProvider.select((state) => state.thirdWidth));
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        width: thirdState,
                        height: 80,
                        duration: const Duration(milliseconds: 500),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ref.read(animationContainerProvider.notifier).extensionThirdWidthInVm(20);
                        },
                        child: const Text('CLICK'),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
