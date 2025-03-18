import 'package:flutter/material.dart';
import 'user.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* 한줄 아래 코드에 주석 필요함. 2025.03.18 변종현 요청 */
    Map<String, Object> args = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    /* MaterialApp 반환 */
    return MaterialApp(
      /* Scafford 구조로 설계 */
      home: Scaffold(
        /* 앱바에 타이틀 출력 */
        appBar: AppBar(
          title: Text('MyPageScreen'),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.back_hand)),
        ),
        /* 본문에 컨테이너 위젯 배치 */
        body: Container(
          color: Colors.yellow,
          /* 컨테이너 안에 들어간 자식 위젯 */
          child: Center(
            child: Column(
              /* 칼럼 기준 세로로 가운데 정렬 */
              mainAxisAlignment: MainAxisAlignment.center,
              /* 자식들에 텍스트와 버튼 출력 */
              children: [
                Container(
                  child: Image.asset('images/MyPage.jpg'),
                ),
                Text(
                  'MyPageScreen',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                /* detail_screen에서 전달한 데이터를 화면에 출력하고 되돌아갈 때
                데이터를 전달한다. */
                Text('sendData:${args["arg1"]}, ${args["arg2"]}, ${(args["arg3"] as User).id}'),
                /* 네번째 페이지로 이동하는 버튼 */
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/four');
                    },
                    child: Text('Scan Wine'),
                ),
                /* 이전 페이지로 이동하는 버튼, User객체(?)에 값을 넣어 전달함. */
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, User('Cath', 'Busan'));
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