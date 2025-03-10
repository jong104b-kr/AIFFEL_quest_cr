import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: Text('SignInPage'),//앱바 타이틀 (html타이틀 태그 비슷하게 작용)
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu)
              )
          ),
          body: Container(
            color: Colors.orange,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SignInPage',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),// 컨테이너, 디테일 스크린 텍스트 삽입
                  SizedBox(height: 20),
                  Container(
                    child: TestScreen(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/two');
                    },
                    child: Text('HomePage'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/five');
                    },
                    child: Text('ScannerPage'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/three');
                    },
                    child: Text('SignInPage'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class TestScreen extends StatefulWidget {
  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<TestScreen> {

  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Form Text'),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'FirstName'
                ),
                validator: (value) {
                  if(value?.isEmpty ?? false) {
                    return 'Please enter first name';
                  }
                  return null;
                },
                onSaved: (String? value){
                  firstName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'lastName'
                ),
                validator: (value) {
                  if(value?.isEmpty ?? false) {
                    return 'Please enter last name';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  lastName = value;
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: (){
              if(_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                print('firstName: $firstName, lastName: $lastName');
              }
            },
            child: Text('submit')
        ),
      ],
    );
  }
}