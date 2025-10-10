import 'package:flutter/material.dart';
import 'user.dart'; // 사용자 정보 임포트 클래스

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            /* 이메일 입력 필드 */
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),

            /* 비밀번호 입력 필드 */
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            /* 비밀번호 확인 입력필드 */
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),

            /* 회원가입 버튼 */
            ElevatedButton(
              onPressed: _handleSignup,
              child: Text('회원가입'),
            ),
            SizedBox(height: 20),

            /* 로그인 페이지로 돌아가기 링크 */
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('로그인 페이지로 돌아가기'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignup() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

  /* 유효성 검사 코드 */
  if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
    _showError('모든 필드를 입력해 주세요.');
    return;
  }

  if(password != confirmPassword) {
    _showError('비밀번호가 일치하지 않습니다.');
    return;
  }

  /* Firestore에 사용자 저장 */
  User.addUser(email, password);

  /* 홈 화면으로 이동 */
  Navigator.pushReplacementNamed(context, '/home');

  /* 사용자 정보 저장 (예제용 단순 저장) */
  User.currentUser = User(email:email,password:password);

  /* 회원가입 성공시 홈화면으로 이동 */
  Navigator.pushReplacementNamed(context,'/home');
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}