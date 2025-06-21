/*
이 Flutter앱의 주요코드는 앱의 초기화와 루트화면을 설정하는 부분이다. 이 코드는
Firebase 초기화, 사용자 데이터 관리, 로그인 및 회원가입 기능을 포함하고 있다.0
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'register.dart';
import 'home.dart';
import 'appbar.dart';
import 'UserDataProvider.dart';
import 'ui_utils.dart'; // UI 유틸리티 함수들을 포함하는 모듈

void main() async {
  /*
  위젯 바인딩을 초기화하여 앱이 실행되기 전에 필요한 초기화를 수행함.
   */
  WidgetsFlutterBinding.ensureInitialized(); // runApp() 호출 전에 위젯 바인딩 초기화

  /*
  Firebase를 초기화함, 현재 플랫폼에 맞는 설정을 적용함.
   */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*
  UserDataProvider 인스턴스를 생성하고 ChangeNotifierProvider를 사용하여 앱의 루트위젯에
  제공한다.
   */
  final userDataProvider = UserDataProvider();

  runApp(
    ChangeNotifierProvider.value(
      value: userDataProvider,
      child: const CertificateStudy(),
    ),
  );
}

/*
MaterialApp : 앱의 루트위젯, 앱의 제목과 색상을 설정함.
theme : ColorScheme을 설정하여 앱의 색상 테마를 정의함.
home : 앱이 시작될 때 기본적으로 표시될 화면을 설정함, 여기서는 MainPage가 루트화면으로 지정됨
 */
class CertificateStudy extends StatelessWidget {
  const CertificateStudy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '서술형도 한다 - AiffelThon 과제',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(title: '서술형도 한다'),
      // 이 위치의 "서술형도 한다" 가 AppBar에 출력되는 문구입니다.
      // 다른 페이지의 AppBar에선 title이라는 변수명으로 호출됩니다.
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({super.key, required this.title});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /*
  id, pw를 입력받기 위한 TextEditingController 객체들임
   */
  final id_input = TextEditingController();
  final pw_input = TextEditingController();

  /*
  로그인 프로세스를 처리하는 함수
   */
  void _processLogin(BuildContext context) async {
    String id = id_input.text.trim();
    String pw = pw_input.text.trim();

    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userDataProviderUtility = UserDataProviderUtility();

    // ID와 비밀번호 입력 필드 검사
    if (id.isEmpty || pw.isEmpty) {
      showSnackBarMessage(context, 'ID와 비밀번호를 모두 입력해주세요.');
      return;
    }

    // UserDataProviderUtility를 통해 ID 기반 로그인 유효성 검사 및 처리 시도
    final ValidationResult result = await userDataProviderUtility.validateAndLoginById(
      id: id,
      pw: pw,
      userDataProvider: userDataProvider,
    );

    print('I/flutter: [LoginProcess] 로그인 결과 isSuccess: ${result.isSuccess}, 메시지: ${result.message}');

    if (!result.isSuccess) {
      showSnackBarMessage(
          context, result.message); // ValidationResult에서 반환된 메시지 사용
      return;
    }

    showSnackBarMessage(context, result.message); // ValidationResult에서 반환된 실패 메시지 사용

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage(title: widget.title)), // 로그인 성공 후 이동할 메인 페이지
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(title: widget.title),
      body: Column(
        children: [
          Image(image: AssetImage('assets/images/logo.png')),
          TextField(
            controller: id_input,
            decoration: InputDecoration(labelText: 'ID : ')
          ),
          TextField(
            controller: pw_input,
            obscureText: true,
            decoration: InputDecoration(labelText: 'PW : ')
          ),
          Row( // 버튼들을 가로로 배치
            mainAxisAlignment: MainAxisAlignment.spaceAround, // 버튼 사이에 공간을 줌
            children: [
              ElevatedButton(
                onPressed: () {
                  _processLogin(context);
                },
                child: Text('로그인'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(title: widget.title),
                    ),
                  );
                },
                child: Text('계정 만들기 / 찾기'),
              ),
            ],
          ),
        ]
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
