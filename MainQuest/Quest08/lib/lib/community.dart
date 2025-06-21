/*
이 플러터 코드는 커뮤니티 페이지라는 화면을 정의하며 사용자가 커뮤니티 게시판으로 이동할 수 있는
두 개의 버튼을 제공한다. 이 화면은 StatelessWidget으로 구현되어 있으며 Scaffold와 ElevatedButton을
사용하여 UI를 구성한다.
 */

import 'package:flutter/material.dart';

import 'freebbs.dart';
import 'qnabbs.dart';
import 'appbar.dart';

/*
StatelessWidget으로 정의되어 있으며, title이라는 필수 매개변수를 받는다. 이 매개변수는 이전 페이지의
제목을 나타낸다.
 */
class CommunityPage extends StatelessWidget {
  final String title; // 이전 페이지 제목을 받을 변수

  const CommunityPage({super.key, required this.title});

  /*
  build()는 UI를 구성하는 메서드이다. Scaffold를 사용하여 화면의 기본구조를 만든다.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* 커스텀 앱바를 설정한다, title값을 전달하여 앱바의 제목을 설정함 */
      appBar: CSAppBar(title: title),
      /* Row 위젯을 사용하여 두 개의 ElevatedButton을 수평으로 배치한다 */
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              // FreeBBSPage로 이동하면서 title 값을 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FreeBBSPage(title: title),
                ),
              );
            },
            child: Text('자유게시판'),
          ),
          ElevatedButton(
            onPressed: () {
              // QnABBSPage로 이동하면서 title 값을 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QnABBSPage(title: title),
                ),
              );
            },
            child: Text('질문게시판'),
          ),
        ]
      ),
    );
  }
}