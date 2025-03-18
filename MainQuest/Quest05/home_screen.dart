import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* MaterialApp 반환 */
    return MaterialApp(
      /* Scaffold 구조로 화면 배치 */
      home: Scaffold(
        /* 앱바에 타이틀 입력 */
        appBar: AppBar(
          title: Text('HomeScreen'),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ),
        /* 본문에 컨테이너 위젯 배치 */
        body: Container(
          color: Colors.red,
          /* 자식 위젯 하나 배치하고 가운데 배치 */
          child: Center(
            /* 세로로 위젯들을 배치하기 위해 컬럼 사용 */
            child: Column(
              /* 세로축 기준 가운데 정렬 */
              mainAxisAlignment: MainAxisAlignment.center,
              /* 글자와 버튼 배치 */
              children: [
                Container(
                  child: Image.asset('images/vivino_home.jpg'),
                ),
                Text(
                  'HomeScreen',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/two');
                    },
                    child: Text('View Details'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}