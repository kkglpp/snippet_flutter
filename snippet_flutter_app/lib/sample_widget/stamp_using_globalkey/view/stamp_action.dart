import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';
import 'package:snippet_flutter_app/sample_widget/stamp_using_globalkey/widget/location_card.dart';
import 'package:snippet_flutter_app/sample_widget/stamp_using_globalkey/widget/simple_circle.dart';

class StampAction extends StatefulWidget {
  const StampAction({super.key});

  @override
  State<StampAction> createState() => _StampActionState();
}

class _StampActionState extends State<StampAction> with TickerProviderStateMixin {
  late GlobalKey targetKey;
  late GlobalKey testKey;
  late GlobalKey btnKey;
  late GlobalKey stampKey;
  late ScrollController scrolllController;
  late double redVerticalLoca;
  late double redHorizontalLoca;
  late double purpleVerticalLoca;
  late double purpleHorizontallLoca;
  late Animation<Offset>? _locaAnimation;
  late Animation<double>? _sizeAnimation;
  late double fixedLoacaRed;
  late double fixedLocaPurple;

  //Stamp  및 Stamp가 들어갈 사이즈
  late double defaultBoxSize;
  late int multipleValueForMaxSize;
  late String scrollOffset;
  late AnimationController _btnStartAnimationCtrl;

  @override
  void initState() {
    super.initState();
    targetKey = GlobalKey();
    testKey = GlobalKey();
    btnKey = GlobalKey();
    stampKey = GlobalKey();
    redVerticalLoca = 0;
    redHorizontalLoca = 0;
    purpleVerticalLoca = 0;
    purpleHorizontallLoca = 0;
    fixedLoacaRed = 0;
    fixedLocaPurple = 0;
    defaultBoxSize = 50;
    multipleValueForMaxSize = 6;
    scrollOffset = "";
    scrolllController = ScrollController()..addListener(changeScrollStateForNow);
    _btnStartAnimationCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _locaAnimation = null;
    _sizeAnimation = null;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setColoredPosition();
        fixedLoacaRed = redVerticalLoca;
        fixedLocaPurple = purpleVerticalLoca;
        setAnimationValue();
      },
    );
  }

  @override
  void dispose() {
    scrolllController.dispose();
    _btnStartAnimationCtrl.dispose();
    super.dispose();
  }

  // Method part
  /// 스탬프의 크기에 넣어주는 animation

  ///애니메이션에 값 셋팅하는 함수
  void setAnimationValue() {
    // stamp의 크기를
    // 시작 위치와 최종 위치를 가져오는 부분
    Offset initOffset = _getBoxPosition(btnKey);
    initOffset = initOffset + Offset(_getBoxSize(btnKey).width / 2, _getBoxSize(btnKey).height / 2);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Offset waitOffset = Offset(screenWidth / 2 - (defaultBoxSize * multipleValueForMaxSize) / 2,
        screenHeight / 2 - (defaultBoxSize * multipleValueForMaxSize / 2)); // 화면 중앙
    Offset finalOffset = _getBoxPosition(targetKey);

    // TweenSequence 자체를 animate에 전달하여 Animatable로 취급
    TweenSequence<Offset> locaTweenSequence = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween<Offset>(begin: initOffset, end: waitOffset), weight: 1),
      TweenSequenceItem(tween: Tween<Offset>(begin: waitOffset, end: finalOffset), weight: 1),
    ]);

    TweenSequence<double> sizeTweenSequence = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: defaultBoxSize * multipleValueForMaxSize), weight: 1),
      TweenSequenceItem(
          tween: Tween<double>(begin: defaultBoxSize * multipleValueForMaxSize, end: defaultBoxSize), weight: 1),
    ]);

    // Animatable로 직접 animate() 메서드로 연결
    _locaAnimation =
        locaTweenSequence.animate(CurvedAnimation(parent: _btnStartAnimationCtrl, curve: Curves.easeInOut));
    _sizeAnimation =
        sizeTweenSequence.animate(CurvedAnimation(parent: _btnStartAnimationCtrl, curve: Curves.easeInOut));
    setState(() {});
  } // end method : setAnimationValue

  /// 애니메이션 실행하는 함수
  void actOnActionBtn() {
    setAnimationValue();
    // 애니메이션 실행
    _btnStartAnimationCtrl.forward(from: 0);
  }

  /// 현재 스크롤 위치로 값 변경하는 함수
  void changeScrollStateForNow() {
    scrollOffset = scrolllController.offset.toStringAsFixed(2);
    setColoredPosition();
  }

  Offset _getBoxPosition(GlobalKey boxKey) {
    // RenderBox로 박스의 정보를 가져옴
    final RenderBox renderBox = boxKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  Size _getBoxSize(GlobalKey boxKey) {
    final RenderBox renderBox = boxKey.currentContext!.findRenderObject() as RenderBox;
    final Size boxSize = renderBox.size;
    return boxSize;
  }

  void moveToPurpleBox() {
    scrolllController.animateTo(fixedLocaPurple - fixedLoacaRed,
        duration: const Duration(milliseconds: 500), curve: Easing.standard);
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
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MaxHeight,
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("미디어 쿼리 빌드 가로 : ${mediaQueryWidth.roundToDouble()}"),
                              Text("미디어 쿼리 빌드 세로 : ${mediaQueryHeight.roundToDouble()}"),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                          ),
                          AnimatedBuilder(
                              animation: _btnStartAnimationCtrl,
                              builder: (context, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text("애니메이션 값 : ${_locaAnimation?.value ?? ""}")],
                                );
                              }),
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
                                    LocationCard(boxSize: defaultBoxSize),
                                    LocationCard(boxSize: defaultBoxSize),
                                    LocationCard(gbKey: targetKey, boxSize: defaultBoxSize, clr: Colors.red[500]),
                                  ],
                                ),
                                Container(
                                  width: 221,
                                  height: 50,
                                  color: Colors.green[100],
                                  child:
                                      const Center(child: Text("빨강의 가로위치 만큼 길이의 박스", style: TextStyle(fontSize: 12))),
                                ),
                                const SizedBox(height: 300),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LocationCard(boxSize: defaultBoxSize),
                                    LocationCard(boxSize: defaultBoxSize),
                                    LocationCard(gbKey: testKey, boxSize: defaultBoxSize),
                                  ],
                                ),
                                const SizedBox(height: 500),
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
                          ElevatedButton(onPressed: moveToPurpleBox, child: const Text("보라색으로 스크롤 이동")),
                          // ElevatedButton(onPressed: () => actOnConfirmTargetKey(), child: Text("targetKey 확인")),
                          ElevatedButton(
                              key: btnKey, onPressed: () => actOnActionBtn(), child: const Text("ActionBtn")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              AnimatedBuilder(
                  animation: _btnStartAnimationCtrl,
                  builder: (context, child) {
                    return Positioned(
                      top: _locaAnimation == null ? 0 : (_locaAnimation!.value.dy - (mediaQueryHeight - MaxHeight)),
                      left: _locaAnimation == null ? 0 : _locaAnimation?.value.dx ?? 0,
                      child: SimpleCircle(boxKey: stampKey, boxSize: _sizeAnimation?.value ?? 0),
                    );
                  })
            ],
          ),
        );
      }),
    );
  }
}
