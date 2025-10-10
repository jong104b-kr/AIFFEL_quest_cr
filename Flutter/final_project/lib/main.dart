import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart'; // 새 파일 추가
import 'signup_page.dart'; // 신규 추가
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // 시작 경로
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/signup': (context) => SignupPage(), // 신규 경로 추가
      },
    );
  }
}