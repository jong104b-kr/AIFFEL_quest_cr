import 'package:flutter/material.dart';
import 'package:flutter_lab/ch12_4_dialog/test.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: Text('HomePage'),//앱바 타이틀 (html타이틀 태그 비슷하게 작용)
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu)
              )
          ),
          body: Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HomePage',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),// 컨테이너, 디테일 스크린 텍스트 삽입
                  SizedBox(height: 20),
                  Container(
                    child: TestScreen(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      '새로 나온 와인들'
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                        // 이미지 삽입
                        // 설명,가격 삽입
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.white60,
                        // 이미지 삽입
                        // 설명,가격 삽입
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                        // 이미지 삽입
                        // 설명,가격 삽입
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.white60,
                        // 이미지 삽입
                        // 설명,가격 삽입
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                        // 이미지 삽입
                        // 설명,가격 삽입
                      )
                    ]
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        child:
                        ElevatedButton(
                          onPressed: () {
                          Navigator.pushNamed(context, '/two');
                          },
                          child: Text('HomePage'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child:
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/five');
                          },
                          child: Text('ScannerPage'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child:
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/three');
                          },
                          child: Text('SignInPage'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class TestScreen extends StatefulWidget {
  @override
  TextState createState() => TextState();
}

class TextState extends State<TestScreen> {
  final controller = TextEditingController();
  int textCounter = 0;

  _printValue() {
    print("_printValue(): ${controller.text}");
    setState(() {
      textCounter = controller.text.length;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_printValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build...");
    return Column(
      children: [
        Text('와인을 검색합니다.'),
        TextField(
          style: TextStyle(fontSize: 10.0),
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Data',
            prefixIcon: Icon(Icons.input),
            border: OutlineInputBorder(),
            hintText: "검색어",
            helperText: "와인이름을 입력하세요.",
            counterText: "$textCounter characters",
            filled: true,
            fillColor: Colors.white70
          ),
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.emailAddress,
          minLines: 5,
          maxLines: 5,
        )
      ],
    );
  }
}