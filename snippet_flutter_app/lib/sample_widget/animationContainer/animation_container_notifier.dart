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

  //상태로 지정된 것이 아니면 setState나 기타방법으로 재랜더링 되기 전에는 반영 되지 않는다.
  void extensionFirstWidthInProvider(double val) {
    firstWidth += 20;
    state = state.copyWith();
  }

  // Notifier에서 직접 값을 늘려서 복사한다.
  void extensionSecondWidthInProvider(double val) {
    print(state.secondWidth);
    // state.secondWidth = state.secondWidth + val;
    state = state.copyWith(secondWidth: state.secondWidth + val);
    print(state.secondWidth);
  }

  //ViewModel 에 있는 함수를 실행하고
  //그 상태를 복사해서 state를 최신화한다.
  void extensionThirdWidthInVm(double val) {
    print("before");
    print(state.thirdWidth);
    print("step1");
    state.extensionThirdWidth(val);
    print("step2");
    print(state.thirdWidth);
    print("step3");
    state = state.copyWith();
    print("step4");
    print(state.thirdWidth);
  }
}//end class
