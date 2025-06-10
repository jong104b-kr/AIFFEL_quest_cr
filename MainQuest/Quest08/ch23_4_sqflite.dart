import 'package:flutter/material.dart';
import 'package:flutter_lab/ch2/test.dart';
import 'package:flutter_lab/ch23_3_preference/test.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* MaterialApp을 반환하며 앱의 제목과 기본 테마를 설정함 */
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativePluginWidget(),
    );
  }
}

/* User클래스는 사용자 정보를 나타내며, id, name, address 필드를 가진다 */
class User {
  int? id; // id는 정수형 값을 가지며, null일 수 있음(null-safe)
  String? name; // name은 문자열 값을 가지며 역시 null일 수 있음
  String? address; // address도 문자열 값을 가지며 null을 허용함

  Map<String,Object?> toMap() { // toMap() 메서드는 User객체를 Map객체로 변환함, 이 메서드는 주로 데이터베이스에 데이터를 저장하기 전에 객체를 Map으로 변환함
    var map = <String,Object?>{"name": name, "address": address}; // 기본적으로 name과 address 속성을 Map에 추가함
    // if(id != null){...} : id가 null이 아닐 경우에만 id도 Map에 추가함, id가 선택적인 속성임을 나타냄.
    if(id!=null) {
      map["id"] = id;
    }
    return map;
  }

  User.fromData(this.name,this.address); // 생성자(fromData), 매개변수 두개 name,address를 받아 User객체를 생성함, 이 생성자는 객체 초기화에 사용함

  /* fromMap생성자는 Map객체를 받아 User객체를 생성함, Map에서 id,name,address를 추출하여
  객체의 속성에 할당함. id,name,address는 Map에서 추출하여 객체의 속성에 할당함
  User 클래스는 사용자 정보를 저장하기 위한 데이터 모델임. toMap() 메서드는 객체를 Map으로 변환하여
  데이터베이스에 저장할 준비를 함, fromData와 fromMap 생성자는 각각 데이터를 통해 객체를 생성하거나
  Map 객체로부터 객체를 생성하는데 사용함.
  이 클래스는 데이터베이스와의 상호작용을 위해 객체와 Map간의 변환을 쉽게 해주는 패턴을 제공함. */
  User.fromMap(Map<String,Object?>map) {
    id = map["id"] as int; // as int는 런타임 타입 캐스팅을 통해 Map의 값을 적절한 타입으로 변환함
    name = map['name'] as String;
    address = map['address'] as String;
  }
}

class NativePluginWidget extends StatefulWidget {
  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {
  @override
  /* initState() 메서드는 플러터의 State클래스에서 중요한 역할을 하며
  특히 위젯의 상태가 초기화될 때 실행되는 특별한 메서드이다. 위젯의 생성자같은 역할이라 생각할 수 있다.
  위젯이 처음 만들어질 때 필요한 모든 초기 설정을 이곳에서 처리함.(db연결, 리소스 로드, 초기 데이터 설정 등)
   */
  void initState() {
    super.initState(); // 부모 클래스 initState() 호출, 부모 클래스에서 수행해야 할 초기화할 작업 호출 및 실행, 계층구조 유지
    /* 위젯의 상태가 초기화될 때 데이터베이스 테이블이 생성되도록 보장함, 이는 위젯이 처음 렌더링되기 전에
    필요한 초기화 작업을 수행하는 좋은 예시임.
     */
    _createTable();
  }

  var db; // SQLite 데이터베이스 객체

  /* db에 질의를 던지는 기능을 보시면 좋겠습니다.
  CREATE(테이블 생성), 데이터베이스를 열고 User테이블을 생성함, 삽입,업데이트,삭제 및 조회
   */
  _createTable() async {
    db = await openDatabase("my_db.db", version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE User(
          id INTEGER PRIMARY KEY,
          name TEXT,
          address Text
        )
        ''');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) {});
  }

  int lastId = 0; // 마지막에 삽입된 Id를 의미함

  /* 삽입 */
  insert() async {
    lastId++;
    User user = User.fromData('name$lastId', 'seoul$lastId');
    lastId = await db.insert("User", user.toMap());
    print('${user.toMap()}');
  }

  /* 수정 */
  update() async {
    User user = User.fromData('name${lastId-1}', 'seoul${lastId-1}');
    await db.update("User",user.toMap(),where: 'id=?', whereArgs: [lastId]);
  }

  /* 삭제 */
  delete() async {
    await db.delete('User',where:'id=?',whereArgs:[lastId]);
    lastId--;
  }

  /* 데이터베이스 쿼리 실행 메서드 */
  query() async {
    List<Map> maps = await db.query( // db.query() 메서드를 호출하여 User테이블에서 데이터를 조회함
      'User',
      columns: ['id','name','address'], // column 매개변수를 통해 쿼리 결과에서 반환할 열을 명시적으로 지정함
    );
    /* users 리스트는 User 객체들을 저장하기 위해 선언됨, growable은 리스트가 동적으로 크기를 조정할 수 있도록 설정함. */
    List<User> users = List.empty(growable: true); // 결과는 List<Map>타입으로 반환되며. 각 요소는 테이블의 행을 나타내는 Map객체
    /* forEach가 dart에서는 메서드로 주어진다, maps 리스트의 각 Map요소를 순회(반복)함 */
    maps.forEach((element) {
      users.add(User.fromMap(element as Map<String,Object?>)); // User.fromMap() 생성자를 통해 User객체로 변환되어 users리스트에 추가됨
    });
    /* 만약 쿼리 결과가 비어있지 않다면, 첫 번째 결과를 콘솔에 출력함, 이는 디버깅 목적으로 사용됨 */
    if(maps.length>0) {
      print('select: ${maps.first}');
    }
    /* users 리스트에 있는 모든 User 객체의 name속성을 콘솔에 출력함.
    이를 통해 db에서 조회한 모든 사용자의 이름을 확인할 수 있음.
     */
    users.forEach((user) {
      print('${user.name}');
    });
  }

  /* build 메서드는 UI를 구성하며 세 개의 버튼을 화면에 표시함 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite")),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              ElevatedButton(
                child: Text('update'),
                onPressed: update,
              ),
              ElevatedButton(
                child: Text('delete'),
                onPressed: delete,
              ),
              ElevatedButton(
                child: Text('query'),
                onPressed: query,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}