import 'package:flutter/material.dart';
import 'package:snippet_flutter_app/const/layout/default_layout.dart';

class BoxText extends StatelessWidget {
  // static String routeName = "RouteForBoxTest";
  const BoxText({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "BoxTest",
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.amber,
                child: const Text("Column > Container > Expanded > Column"),
              ),
              SizedBox(
                child: Column(
                  children: [
                    ...List.generate(2, (index) => DummyWidget(msg: index)),
                    ...List.generate(2, (index) => DummyWidget(msg: index + 10)),
                  ],
                ),
              ),
              const Divider(),
              Container(
                color: Colors.grey,
                child: Row(
                  children: [
                    Container(color: Colors.green, width: 50, height: 100),
                    Expanded(
                      child: Column(
                        children: [
                          const Row(
                            children: [Text("Gridview 시작.")],
                          ),
                          GridView.builder(
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200, // 각 항목의 최대 너비를 200으로 설정
                                crossAxisSpacing: 10, // 열 간의 간격
                                mainAxisSpacing: 10, // 행 간의 간격
                                childAspectRatio: 1.5, // 자식 항목의 가로 세로 비율
                              ),
                              shrinkWrap: true, // GridView의 높이를 고정
                              itemCount: 10,
                              itemBuilder: (context, index) => DummyWidget(msg: index)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DummyWidget extends StatelessWidget {
  final int msg;
  const DummyWidget({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        color: Colors.amber,
        border: Border.all(color: Colors.black),
      ),
      child: Center(child: Text(msg.toString())),
    );
  }
}
