import 'package:flutter/material.dart';
import 'image_picker_test.dart';

class ScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* Scafford 형태로 화면을 구성한다. */
      home: Scaffold(
        /* 타이틀 부분(appBar)에 화면명 출력 */
        appBar: AppBar(
          title: Text('ScannerScreen'),
          centerTitle: true,
          leading: IconButton(onPressed: () {
            home: NativePluginWidget();
          }, icon: Icon(Icons.camera)),
        ),
        /* 본문 디자인, 컨테이너 위젯에 담는다. */
        body: Container(
          color: Colors.cyan,
          /* 하나의 객체 안에 답는다. */
          child: Center(
            child: Column(
              /* 칼럼(세로)기준 가운데 정렬 */
              mainAxisAlignment: MainAxisAlignment.center,
              /* 칼럼 안에 여러 개의 위젯 배치(설계) */
              children: [
                Container(
                  child: Image.asset('images/ScannerPage.jpg'),
                ),
                /* 문자열 화면 출력 */
                Text(
                  'ScannerScreen',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                /* 버튼 출력 */
                ElevatedButton(
                    onPressed: () {
                      /* 페이지 이동 코드 */
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}