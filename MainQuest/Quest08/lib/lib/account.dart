import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 패턴을 통해 상태관리를 쉽게 할 수 있도록 도와주는 패키지

import 'modifyaccount.dart';
import 'appbar.dart';
import 'deleteaccount.dart';
import 'UserDataProvider.dart';

/* StatefulWiget으로 정의함, 생성자에는 title이라는 필수 매개변수를 받는다 */
class AccountInfoPage extends StatefulWidget {
  final String title;

  const AccountInfoPage({super.key, required this.title});

  /* 화면의 상태를 관리하는 클래스 */
  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {

  /* build() 메서드는 UI를 구현하는 부분 */
  @override
  Widget build(BuildContext context) {
    /* Scaffold()는 기본적인 화면 구조를 제공하며, appBar와 body속성을 가짐 */
    return Scaffold(
      appBar: CSAppBar(title: widget.title), // widget.title로 접근
      /* Column() 은 수직으로 위젯을 나열함 */
      body: Column(
        children: [
          // UserDataProvider의 변경을 수신 대기하는 Consumer 위젯을 사용하여
          // ID와 E메일 텍스트만 업데이트되도록 합니다.
          Consumer<UserDataProvider>(
            builder: (context, userDataProvider, child) {
              final String? email = userDataProvider.loggedInUserEmail;
              return Column( // 여러 텍스트 위젯을 포함하기 위해 Column으로 감쌉니다.
                crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
                children: [
                  FutureBuilder<String?>( // FutureBuilder로 ID를 비동기적으로 로드하여 표시
                    future: userDataProvider.loggedInUserId, // UserDataProvider에서 loggedInId Future를 가져옵니다.
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 데이터 로딩 중
                        return const Text("ID : 불러오는 중...");
                      } else if (snapshot.hasError) {
                        // 오류 발생 시
                        return Text("ID : 오류 발생 (${snapshot.error})");
                      } else if (snapshot.hasData && snapshot.data != null) {
                        // 데이터가 성공적으로 로드되었을 때
                        return Text("ID : ${snapshot.data}");
                      } else {
                        // 데이터가 없거나 로그인되지 않은 경우
                        return const Text("ID : 로그인되지 않음");
                      }
                    },
                  ),
                  // E메일은 동기적으로 사용 가능
                  Text("E메일 : ${email ?? '불러오는 중...'}"), // email이 null일 경우 대비
                ],
              );
            },
          ),
          const Text(
            '회원정보창입니다. 이 자리에 본인의 학습 내역이 들어올 예정입니다.',
          ),
          Text(
            '현재 수정 및 탈퇴 기능은 작동하지 않음을 유의하십시오!',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModifyAccountPage(title: widget.title), // ModifyPage로 변경된 이름 사용
                    ),
                  );
                },
                child: const Text('수정'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteAccountPage(title: widget.title),
                    ),
                  );
                },
                child: const Text('탈퇴'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}