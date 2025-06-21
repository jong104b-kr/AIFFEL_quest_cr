/*
CSAppBar라는 커스텀 앱바 위젯을 정의함, 이 앱바는 StatefulWidget으로 구현되어 있으며,
Provider패턴을 사용하여 사용자 데이터를 관리한다. Provider와 Consumer를 사용하여 데이터 변경을
효과적으로 처리하며, 사용자 경험을 개선한다.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UserDataProvider.dart';
import 'main.dart';
import 'account.dart';

/*
StatefulWidget으로 정의되어 있으며, PreferredSizeWidget을 구현하여 앱바의 크기를 명시한다.
title이라는 필수 매개변수를 받아 앱바의 제목을 설정한다.
 */
class CSAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CSAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CSAppBar> createState() => _CSAppBarState();
}

/*
initState() 메서드 : 앱바의 위젯이 처음 생성될 때 호출된다.
addPostFrameCallback() : 프레임 렌더링이 완료된 직후에 실행될 콜백을 예약함, 이 콜백은
notifyListeners()를 호출하여 UserDataProvider의 리스너들에게 데이터 변경을 알린다.
 */
class _CSAppBarState extends State<CSAppBar> { // State 클래스 생성
  @override
  void initState() {
    super.initState();
    // !!! 중요: 이 부분이 핵심 로직입니다. !!!
    // 현재 프레임 렌더링이 완료된 직후에 실행될 콜백을 예약합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 위젯이 여전히 위젯 트리에 마운트되어 있는지 확인합니다.
      if (mounted) {
        // Provider.of를 사용하여 UserDataProvider 인스턴스를 가져온 후 notifyListeners()를 호출합니다.
        // listen: false는 이 Provider.of 호출 자체가 위젯을 리빌드하지 않도록 합니다 (여기서는 notifyListeners만 목적).
        Provider.of<UserDataProvider>(context, listen: false).notifyListeners();
        print('>>> _CSAppBarState initState: addPostFrameCallback - notifyListeners() 호출됨.');
      }
    });
  }

  /*
  AppBar위젯을 사용하여 앱바를 구성함. Provider.of를 사용하여 현재 컨텍스트에서
  UserDataProvider 인스턴스를 가져온다. 로그인 여부에 따라 앱바의 동작을 다르게 설정한다.
  Consumer위젯을 사용하여 UserDataProvider의 변경사항을 감지하고 UI를 동적으로 업데이트한다.
  로그인된 사용자에게는 로그아웃 버튼과 회원정보 버튼을 제공한다. 로그아웃 버튼을 누르면,
  logoutUser() 메서드를 호출하고, 로그아웃 완료 후 메인 페이지로 이동한다. 회원정보 버튼을 누르면
  AccountInfoPage로 네비게이션된다.
   */
  @override
  Widget build(BuildContext context) {

    final userDataProvider = Provider.of<UserDataProvider>(context);
    final bool isLoggedIn = userDataProvider.isLoggedIn;

    print('CSAppBar 빌드 중: isLoggedIn = $isLoggedIn');

    /*
    디버그 print 문 추가 : 코드 중간중간에 디버깅을 위한 프린트문을 추가하여 현재 로그인 상태와
    사용자 정보를 콘솔에 출력한다.
     */
    print('CSAppBar 빌드 중: isLoggedIn = $isLoggedIn');
    print('현재 로그인된 사용자 ID: ${userDataProvider.loggedInUserId.toString()}'); // Future이므로 toString()으로 일단 출력
    print('현재 로그인된 사용자 이메일: ${userDataProvider.loggedInUserEmail}');

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
      actions: <Widget>[
        Consumer<UserDataProvider>( // Consumer 위젯 추가
          builder: (context, userDataProvider, child) {
            final bool isLoggedIn = userDataProvider.isLoggedIn;

            // 디버그 print 문 (Consumer 내부)
            print('Consumer in CSAppBar rebuild: isLoggedIn = $isLoggedIn');
            print('Consumer in CSAppBar rebuild: loggedInEmail = ${userDataProvider.loggedInUserEmail}');

            if (isLoggedIn) {
              // 로그인 상태일 때만 loggedInId 디버그 print 실행
              userDataProvider.loggedInUserId.then((id) {
                print('Consumer in _CSAppBarState: loggedInId (resolved) = $id');
              });
              return Row(
                  children: [
                    ElevatedButton(
                        child: const Text('로그아웃'),
                        onPressed: () async {
                          await userDataProvider.logoutUser(); // Consumer의 userDataProvider 사용
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('로그아웃 되었습니다.')),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(title: widget.title),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                    ),
                    ElevatedButton(
                        child: const Text('회원정보'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountInfoPage(title: widget.title),
                            ),
                          );
                        }
                    ),
                  ]
              );
            } else {
              // 로그인되지 않은 상태에서는 아무것도 표시하지 않거나, 다른 위젯 표시
              return Container(); // 빈 컨테이너 반환
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}