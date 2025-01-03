import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final TextWidgetType type;
  const CustomTextWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    TextWidgetTheme boxTheme = type.theme;
    if (boxTheme is GeneralTheme) {
      return CustomGeneralTextWidget(message: "general");
    } else {
      return CustomWarningTextWidget(message: "Warning");
    }
  }
}

class CustomGeneralTextWidget extends StatelessWidget {
  final String message;

  const CustomGeneralTextWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
        color: Colors.green[100],
      ),
      child: Text(message),
    );
  }
}

class CustomWarningTextWidget extends StatelessWidget {
  final String message;
  const CustomWarningTextWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
        color: Colors.red[200],
      ),
      child: Text(message),
    );
  }
}

/* 옵션을 주는 방법에 대해서 테스트를 진행하자 */

/// 생성자로 구분한다?
/// parameter를 추상화 시켰을때, 생성자로 구분하면, parameter 의 타입/클래스 를 원하는 형태로 구분지어 줄 수 있다.
/// parameter 를 1:1 혹은 1:n으로 짝지어야 할때 유용하다?
/// 그리고 새로운 class 안에 들어가는 prameter의 개수나 종류가 다를때 또한 유용하다. 각 Theme를 이용해서 reurn 하는 위젯을 다르게 하면
/// 실제 화면에서 코딩할때, 호출하는 클래스의 이름이 통일 되어있어서 코드가 보기 좋아진다.
///
/// 그럼에도 get으로 설정하는 경우에는 뭐가 다를까
///

class TextWidgetType {
  final TextWidgetTheme theme;

  //걍 생성자로 부를때
  TextWidgetType({
    required this.theme,
  });

  //닷을 이용한 생성자 구분을 통해 부를때
  TextWidgetType.warning({
    required WarningTheme this.theme,
  });
  TextWidgetType.general({required GeneralTheme this.theme});
}

/* class TextWidgetTheme  */

abstract class TextWidgetTheme {}

class GeneralTheme extends TextWidgetTheme {}

class WarningTheme extends TextWidgetTheme {}
