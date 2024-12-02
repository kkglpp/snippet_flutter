class AnimationContainerVm {
//field
  double secondWidth;
  double thirdWidth;

  //여기서 아무리 값을 바꿔봤자, 랜더링 다시 되기 전에는 반영 되지 않는다.
  void extensionThirdWidth(double val) {
    print(thirdWidth);
    thirdWidth += val;
    print(thirdWidth);
  }

  AnimationContainerVm({
    this.secondWidth = 100,
    this.thirdWidth = 100,
  });
  // copyWith 메서드 추가
  AnimationContainerVm copyWith({
    double? secondWidth,
    double? thirdWidth,
  }) {
    return AnimationContainerVm(
      secondWidth: secondWidth ?? this.secondWidth,
      thirdWidth: thirdWidth ?? this.thirdWidth,
    );
  }
}//end Class
