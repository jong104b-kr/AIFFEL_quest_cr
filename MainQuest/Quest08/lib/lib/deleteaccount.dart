/*
이 플러터 코드는 DeleteAccountPage라는 화면을 정의하며 사용자가 자신의 계정을 삭제할 수 있는
기능을 제공한다. 이 화면은 StatefulWidget으로 구현되어 있으며, Provider패턴을 사용하여
사용자 데이터를 관리한다. UI 유틸리티 함수를 사용하여 오류 메시지를 표시하는 등의 작업을 수행함.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'UserDataProvider.dart';
import 'appbar.dart';
import 'ui_utils.dart'; // ui 유틸리티 함수들을 포함하는 모듈

/*
StatefulWidget으로 정의되어 있으며, title이라는 필수 매개변수를 받는다.
 */
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key, required this.title});
  final String title;

  /*
  State<DeleteAccountPage>는 화면의 상태를 관리하는 클래스이다.
   */
  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  late UserDataProvider userDataProvider;
  late UserDataProviderUtility utility;
  /*
  각각 id, pw, email을 입력받기 위한 TextEditingController 객체들이다.
   */
  final _id = TextEditingController();
  final _email = TextEditingController();
  final _pw = TextEditingController();

  /*
  앱바 위젯이 처음 생성될 때 호출되며 UserDataProvider 인스턴스를 가져온다.
   */
  @override
  void initState() {
    super.initState();
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    utility = UserDataProviderUtility();
  }

  /*
  계정 삭제 함수로직을 가지고 있다.
   */
  void _deleteAccount(BuildContext context) async {
    final id = _id.text.trim();
    final email = _email.text.trim();
    final pw = _pw.text.trim();

    if (id.isEmpty || email.isEmpty || pw.isEmpty) {
      showSnackBarMessage(context, '모든 정보를 입력해주세요.');
      return; // 유효성 검사 실패 시 함수 종료
    }

    /*
    validateAndDeleteUser 유틸리티 함수를 호출하여 계정 삭제를 시도한다.
     */
    final ValidationResult result = await utility.validateAndDeleteUser(
      id: id,
      email: email,
      pw: pw,
      userDataProvider: userDataProvider,
    );

    /* 성공 시에 로그아웃하고 메인 페이지로 이동함 */
    if (!result.isSuccess) {
      showSnackBarMessage(context, result.message);
      return;
    }

    showSnackBarMessage(context, result.message); // 성공 메시지를 SnackBar로 표시

    _id.clear(); // ID 필드 초기화
    _email.clear(); // E메일 필드 초기화
    _pw.clear(); // 비밀번호 필드 초기화

    // 탈퇴 이메일 전송 후에는 사용자에게 로그인 페이지로 돌아가도록 안내
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainPage(title: widget.title)),
          (Route<dynamic> route) => false,
    );
  }

  /*
  build() 메서드, TextField와 ElevatedButton을 사용하여 UI를 구성함.
  id,pw,email을 입력받는 필드와 회원탈퇴 버튼을 배치함.
   */
  @override
  Widget build(BuildContext context) {
    /*
    Scaffold위젯을 사용하여 화면의 기본구조를 만든다.
     */
    return Scaffold(
      appBar: CSAppBar(title: widget.title), // CSAppBar를 사용하여 커스텀 앱바를 추가함.
      body: Column(
        children: [
          /* id,pw,email을 입력받을 수 있는 필드를 만든다 */
          TextField(controller: _id, decoration: const InputDecoration(labelText: 'ID')),
          TextField(
            controller: _pw,
            obscureText: true,
            decoration: const InputDecoration(labelText: '비밀번호'),
          ),
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'E-mail')),
          ElevatedButton( // 회원탈퇴 버튼을 구현함.
            onPressed: () => _deleteAccount(context),
            child: const Text('회원 탈퇴'),
          ),
        ],
      ),
    );
  }
}
