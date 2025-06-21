/*
이 Flutter코드는 ChangePWPage라는 화면으로, 사용자가 비밀번호를 변경할 수 있는 기능을 제공함.
이 화면은 StatefulWidget으로 구현되어 있으며, Provider패턴을 사용하여 사용자 데이터를 관리함.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 상태관리를 위한 패키지, Provider, Consumer위젯을 제공함

import 'appbar.dart'; // 커스텀 앱바 위젯을 정의하는 모듈
import 'ui_utils.dart'; // UI 유틸리티 함수들을 포함하는 모듈
import 'UserDataProvider.dart'; // 사용자 데이터를 관리하는 데이터 제공자 클래스
import 'main.dart'; // 앱의 메인파일, MainPage 찾기

/*
StatefulWidget으로 정의되어 있으며, title이라는 필수 매개변수를 받는다.
State<ChangePWPage>는 화면의 상태를 관리하는 클래스이다.
 */
class ChangePWPage extends StatefulWidget {
  const ChangePWPage({super.key, required this.title});

  final String title;

  @override
  State<ChangePWPage> createState() => _ChangePWPageState();
}

/*
_id와 _email 컨트롤러 : ID와 email을 입력받기 위한 TextEditingController 객체들
initState() 메서드 : 앱바 위젯이 처음 생성될 때 호출되며 UserDataProvider 인스턴스를 가져옴.
 */
class _ChangePWPageState extends State<ChangePWPage> {
  late UserDataProvider userDataProvider;
  late UserDataProviderUtility utility;
  final _id = TextEditingController();
  final _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    utility = UserDataProviderUtility();
  }

  void _changePW() async {
    final String id = _id.text.trim();
    final String email = _email.text.trim();

    // ID 또는 이메일이 비어있는 경우 먼저 검사
    if (id.isEmpty || email.isEmpty) {
      showSnackBarMessage(context, 'ID와 E메일을 모두 입력해주세요.');
      return;
    }

    /*
    _changePW 함수 : 비밀번호 변경 로직을 포함하고 있음.
    id,email이 비어 있는지 검사함, validateAndChangePW 유틸리티 함수를 호출하여 비밀번호 변경을 시도함.
    성공시에는 로그아웃하고 메인페이지로 이동함, 실패시에는 오류메시지를 표시함.
     */
    final ValidationResult result = await utility.validateAndChangePW(
      id: id,
      email: email,
      userDataProvider: userDataProvider,
    );

    if (!result.isSuccess) {
      showSnackBarMessage(context, result.message);
      return;
    }

    showSnackBarMessage(context, result.message); // 성공 메시지를 SnackBar로 표시

    await userDataProvider.logoutUser();
    // 비밀번호 재설정 이메일 전송 후에는 사용자에게 로그인 페이지로 돌아가도록 안내
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainPage(title: widget.title)),
          (Route<dynamic> route) => false,
    );

    _id.clear(); // ID 필드 초기화
    _email.clear(); // E메일 필드 초기화
  }

  /*
  TextField와 ElevatedButton을 사용하여 UI를 구성함, 입력필드와 비밀번호 변경버튼을 배치함.
  UI 구성 : Scaffold를 사용하여 화면의 기본구조를 만듬, CSAppBar를 사용하여 커스텀 앱바를 추가함.
  TextField를 사용하여 ID와 이메일을 입력받을 수 있는 필드를 만듬.
  ElevatedButton을 사용하여 비밀번호 변경버튼을 만듬.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(title: widget.title),
      body: Column(
        children: [
          TextField(
            controller: _id,
            decoration: const InputDecoration(labelText: 'ID'),
          ),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'E-mail'),
          ),
          ElevatedButton(
            onPressed: () => _changePW(),
            child: Text('비밀번호 변경'),
          ),
        ],
      ),
    );
  }
}

/*
이 코드는 사용자가 비밀번호를 변경할 수 있는 화면을 구현하며 사용자 인증상태를 확인하고
필요한 경우 로그아웃 후 메인페이지로 이동함. 또한, UI유틸리티 함수를 사용하여 오류 메시지를
표시하는 등의 작업을 수행함.
 */