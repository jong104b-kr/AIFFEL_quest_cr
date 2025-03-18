import 'package:flutter/material.dart';
import 'user.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* materialapp 반환 */
    return MaterialApp(
      /* scafford 구조 */
      home: Scaffold(
        /* 앱바에는 타이틀 출력 */
        appBar: AppBar(
          title: Text('DetailScreen'),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.alarm)),
        ),
        /* 본문에 컨테이너 위젯 배치 */
        body: Container(
          color: Colors.green,
          /* 자식 위젯으로 화면 구성, 중앙에 출력 */
          child: Center(
            /* 세로로 배치 */
            child: Column(
              /* 세로축 기준 가운데 정렬 */
              mainAxisAlignment: MainAxisAlignment.center,
              /* 텍스트와 버튼 배치(설계) */
              children: [
                Container(
                  child: Image.asset('images/DetailPage.jpg'),
                ),
                Text(
                  'DetailScreen',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                /* mypage_screen으로 이동하면서 데이터를 전달하고, mypage_screen에서
                되돌아올 때 전달받은 데이터를 로그로 출력 */
                ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                          context,
                          '/three',
                          arguments: {
                            "arg1": 'ID_Bob',
                            "arg2": "PW_101",
                            "arg3": User('Bob','Seoul')
                          }
                      );
                      /* 디버그 콘솔창에 결과로그 출력 및 확인 */
                      print('result:${(result as User).id}');
                    },
                    child: Text('My Page'),
                ),
                ElevatedButton(
                    onPressed: () {
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