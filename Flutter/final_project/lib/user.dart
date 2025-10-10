/* lib/user.dart */
import 'package:final_project/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String password; // 예제이므로 평문 저장(실제로는 해시 처리 필요)

  User({required this.email, required this.password});

  /* 저장된 사용자 조회 (단순 예제용 */
  static User? currentUser;

  /* Firestore에 사용자 저장 */
  static Future<void> addUser(String email, String password) async {
    final userDoc = await firestore.collection('users').add({
      'email': email,
      'password': password, // 실제 환경에서는 해시처리 필수!
    });
  }

  /* 사용자 조회 */
  static Future<User?> getUser(String email) async {
    final querySnapshot = await firestore.collection('users').where(
        'email', isEqualTo: email).get();

    if (querySnapshot.docs.isEmpty) return null;

    return User(email: querySnapshot.docs[0]['email'],
        password: querySnapshot.docs[0]['password']);
  }
}

/*
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
*/