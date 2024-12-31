import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:snippet_flutter_app/sample_widget/stamp_using_globalkey/widget/location_card.dart';

class StampAction extends StatefulWidget {
  const StampAction({super.key});

  @override
  State<StampAction> createState() => _StampActionState();
}

class _StampActionState extends State<StampAction> {
  late GlobalKey targetKey;
  late GlobalKey testKey;
  late ScrollController scrolllController;
  late double redVerticalLoca;
  late double redHorizontalLoca;
  late double purpleVerticalLoca;
  late double purpleHorizontallLoca;
  late double fixedLoacaRed;
  late double fixedLocaPurple;
  late String scrollOffset;
  @override
  void initState() {
    super.initState();
    targetKey = GlobalKey();
    testKey = GlobalKey();
    redVerticalLoca = 0;
    redHorizontalLoca = 0;
    purpleVerticalLoca = 0;
    purpleHorizontallLoca = 0;
    fixedLoacaRed = 0;
    fixedLocaPurple = 0;
    scrollOffset = "";
    scrolllController = ScrollController()..addListener(printPresentScroll);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setColoredPosition();
        fixedLoacaRed = redVerticalLoca;
        fixedLocaPurple = purpleVerticalLoca;
      },
    );
  }

  @override
  void dispose() {
    scrolllController.dispose();
    super.dispose();
  }

  void printPresentScroll() {
    // print("현재 스크롤의 위치 ");
    // print(double.parse(scrolllController.offset.toStringAsFixed(2)));
    scrollOffset = scrolllController.offset.toStringAsFixed(2);
    setColoredPosition();
  }

  Offset _getBoxPosition(GlobalKey boxKey) {
    // RenderBox로 박스의 정보를 가져옴
    final RenderBox renderBox = boxKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  void moveToPurpleBox() {
    scrolllController.animateTo(fixedLocaPurple - fixedLoacaRed,
        duration: Duration(milliseconds: 500), curve: Easing.standard);
  }

  void setColoredPosition() {
    redVerticalLoca = _getBoxPosition(targetKey).dy;
    redHorizontalLoca = _getBoxPosition(targetKey).dx;
    purpleVerticalLoca = _getBoxPosition(testKey).dy;
    purpleHorizontallLoca = _getBoxPosition(testKey).dx;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "도장 액션",
      body: LayoutBuilder(builder: (context, constraints) {
        double MaxWidth = constraints.maxWidth;
        double MaxHeight = constraints.maxHeight;
        double mediaQueryWidth = MediaQuery.of(context).size.width;
        double mediaQueryHeight = MediaQuery.of(context).size.height;
        return Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("레이아웃 빌드 가로 : ${MaxWidth.roundToDouble()}"),
                        Text("레이아웃 빌드 세로 : ${MaxHeight.roundToDouble()}"),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("미디어 쿼리 빌드 가로 : ${mediaQueryWidth.roundToDouble()}"),
                        Text("미디어 쿼리 빌드 세로 : ${mediaQueryHeight.roundToDouble()}"),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("빨강 세로기준 위치 : ${redVerticalLoca.roundToDouble()}"),
                        Text("빨강 가로기준 위치 : ${redHorizontalLoca.roundToDouble()}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("스크롤 값 : $scrollOffset")],
                    )
                  ],
                ),
              ), // 상단 초록 박스 카드
              Expanded(
                child: SingleChildScrollView(
                    controller: scrolllController,
                    child: Container(
                      height: 1000,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LocationCard(),
                              LocationCard(),
                              LocationCard(gbKey: targetKey, clr: Colors.red[500]),
                            ],
                          ),
                          Container(
                            width: 221,
                            height: 50,
                            color: Colors.green[100],
                            child: Center(child: Text("빨강의 가로위치 만큼 길이의 박스", style: TextStyle(fontSize: 12))),
                          ),
                          SizedBox(height: 300),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LocationCard(),
                              LocationCard(),
                              LocationCard(gbKey: testKey),
                            ],
                          ),
                          SizedBox(height: 500),
                        ],
                      ),
                    )),
              ),
              Container(
                color: Colors.grey,
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: moveToPurpleBox, child: Text("보라색으로 스크롤 이동")),
                    // ElevatedButton(onPressed: () => actOnConfirmTargetKey(), child: Text("targetKey 확인")),
                    ElevatedButton(onPressed: () {}, child: Text("ActionBtn")),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
