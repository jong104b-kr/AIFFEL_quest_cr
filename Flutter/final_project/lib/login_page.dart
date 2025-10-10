import 'package:flutter/material.dart';
import 'user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = 'test@example.com'; // 테스트용 입력값
    _passwordController.text = '12345678';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Colors.red),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Colors.red),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                // onPrimary: Colors.white,
              ),
              child: Text('로그인'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text('회원가입 하기',style: TextStyle(color: Colors.blue)),
            )
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('로그인 시도: email=$email,password=$password');

    if(email.isEmpty || password.isEmpty) {
      _showError('이메일과 비밀번호를 입력해주세요.');
      return;
    }

    /* Firestore에서 사용자 조회 */
    User.getUser(email).then((user) {
      if(user!=null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
      else {
        _showError('이메일 또는 비밀번호가 잘못되었습니다.');
      }
    });

    /* 테스트용 즉시 성공 처리 */
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}