import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snippet_flutter_app/sample_widget/animationContainer/animation_container_vm.dart';

final animationContainerProvider =
    StateNotifierProvider.autoDispose<AnimationContainerNotifier, AnimationContainerVm>((ref) {
  AnimationContainerVm vm = AnimationContainerVm();
  AnimationContainerNotifier notifier = AnimationContainerNotifier(vm);
  return notifier;
});

class AnimationContainerNotifier extends StateNotifier<AnimationContainerVm> {
  AnimationContainerNotifier(super.state);

  double firstWidth = 100;

  void extensionFirstWidthInProvider(double val) {
    firstWidth += 20;
  }

  // 가로 늘리기.
  void extensionSecondWidthInProvider(double val) {
    print(state.secondWidth);
    // state.secondWidth = state.secondWidth + val;
    state = state.copyWith(secondWidth: state.secondWidth + val);
    print(state.secondWidth);
  }

  void extensionThirdWidthInVm(double val) {
    print(state.thirdWidth);
    state.extensionThirdWidth(val);
    print(state.thirdWidth);
  }
}//end class
