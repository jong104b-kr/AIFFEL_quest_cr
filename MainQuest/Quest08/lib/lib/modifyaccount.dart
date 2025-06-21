/*
이 플러터 코드는 ModifyAccountPage라는 화면을 정의하며, 사용자가 이메일 주소를 변경할 수
있는 기능을 제공함. 이 화면은 StatefulWidget으로 구현되어 있으며, Provider패턴을 사용하여
사용자 데이터를 관리함.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'changepw.dart'; // 비밀번호 변경 화면을 정의하는 모듈
import 'appbar.dart';
import 'ui_utils.dart';
import 'UserDataProvider.dart'; // 사용자 데이터를 관리하는 데이터 제공자 클래스
import 'main.dart';

/*
StatefulWidget으로 정의되어 있으며, title이라는 필수 매개변수를 받는다.
 */
class ModifyAccountPage extends StatefulWidget {
  const ModifyAccountPage({super.key, required this.title});

  final String title;

  /* 화면의 상태를 관리하는 클래스 */
  @override
  State<ModifyAccountPage> createState() => _ModifyAccountPageState();
}

/*
id,pw,기존,신규email 입력받기 위한 TextEditingController 객체
 */
class _ModifyAccountPageState extends State<ModifyAccountPage> {
  late UserDataProvider userDataProvider;
  late UserDataProviderUtility utility;
  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _email = TextEditingController();
  final _newEmail = TextEditingController();

  /*
  위젯이 의존성 변경 시 호출되며, UserDataProvider 인스턴스를 가져온다.
   */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    utility = UserDataProviderUtility();
  }

  /*
  이메일 변경로직을 포함하고 있다.
   */
  void _changeEmail() async {
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final String id = _id.text.trim();
    final String pw = _pw.text.trim();
    final String email = _email.text.trim();
    final String newEmail = _newEmail.text.trim();

    if (id.isEmpty || pw.isEmpty || email.isEmpty || newEmail.isEmpty) {
      showSnackBarMessage(context, '모든 필드를 입력해주세요.');
      return; // 유효성 검사 실패 시 함수 종료
    }
    // 여기까지 통과하면 최소한 필드가 비어있지는 않음

    // 기존의 비즈니스 로직 유효성 검사는 UserDataProviderUtility 내부에서 계속 수행됩니다.
    final ValidationResult result = await utility.validateAndChangeEmail( // 반환 타입이 ValidationResult
      id: id,
      pw: pw,
      email: email,
      newEmail: newEmail,
      userDataProvider: userDataProvider,
    );

    if (!result.isSuccess) {
      showSnackBarMessage(context, result.message);
      return;
    }

    showSnackBarMessage(context, '새 E메일 주소로 확인 링크를 보냈습니다. 링크를 클릭하여 E메일 변경을 완료해주세요.');

    await userDataProvider.logoutUser();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(title: widget.title), // 로그인 페이지로 이동
      ),
      (Route<dynamic> route) => false,
    );

    _id.clear();
    _pw.clear();
    _email.clear();
    _newEmail.clear();
  }

  /*
  UI구성 : Scaffold, CSAppBar, TextField, ElevatedButton
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
            controller: _pw,
            obscureText: true,
            decoration: const InputDecoration(labelText: '비밀번호'),
          ),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: '기존의 E-mail'),
          ),
          TextField(
            controller: _newEmail,
            decoration: const InputDecoration(labelText: '변경할 E-mail'),
          ),
          ElevatedButton(
            onPressed: () => _changeEmail(),
            child: Text('E메일 주소 변경'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePWPage(title: widget.title),
                ),
              );
            },
            child: Text('비밀번호 재설정 페이지로'),
          ),
        ],
      ),
    );
  }
}