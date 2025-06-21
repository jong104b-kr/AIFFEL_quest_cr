/*
이 플러터 코드는 질문답변 게시판 화면을 정의하며 질문게시판의 자리를 표시하는 간단한 기능을
제공한다. StatelessWidget으로 구현되어 있으며 Scaffold와 Center위젯을 사용하여 UI를 구성함.
이 화면은 질문게시판 기능이 추가되기 전의 플레이스 홀더로 사용될 수 있다.
 */
import 'package:flutter/material.dart';

import 'appbar.dart';

/*
StatelessWidget으로 정의되어 있으며 title이라는 필수 매개변수를 받는다. 이 매개변수는
이전 페이지의 제목을 나타낸다.
 */
class QnABBSPage extends StatelessWidget {
  final String title; // 이전 페이지 제목을 받을 변수

  const QnABBSPage({super.key, required this.title});

  /* UI를 구성하는 메서드, Scaffold를 사용하여 화면의 기본구조를 만든다 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(title: title), // 커스텀 앱바를 설정함
      body: const Center( // 화면 중앙에 배치
        child: Text( // Text 위젯
          '질문게시판이 들어올 자리입니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}