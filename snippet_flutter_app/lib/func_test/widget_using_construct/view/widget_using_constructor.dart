import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/layout/base_layout.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:snippet_flutter_app/func_test/widget_using_construct/widget/custom_text_widget.dart';

class WidgetUsingConstructor extends StatelessWidget {
  const WidgetUsingConstructor({super.key});

  @override
  Widget build(BuildContext context) {
    String text1 = "첫번째 텍스트";
    return DefaultLayout(
        title: "생성자로 구분한 Wiget 불러오기",
        body: Center(
          child: Column(
            children: [
              CustomTextWidget(type: TextWidgetType.general(theme: GeneralTheme())),
              CustomTextWidget(type: TextWidgetType.warning(theme: WarningTheme())),
              CustomTextWidget(type: TextWidgetType(theme: GeneralTheme()))
            ],
          ),
        ));
  }
}
