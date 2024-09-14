import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/dol_screen.dart';
import 'screens/hash_screen.dart';
import 'screens/briefcase_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/hash_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  // 날짜 형식 초기화 후 애플리케이션 실행
  runApp(MyApp());
}

Future<void> _onBackPressed(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Do you want to exit?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(), 
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      home: MainPage(), // 메인 페이지 설정
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스
  String message = 'Waiting for server response...';  // 서버 응답 메시지를 저장하는 변수

  @override
  void initState() {
    super.initState();
    // testServerConnection();  // 앱 시작 시 서버에 연결 시도
  }

  // 서버에 연결하여 응답을 받는 함수
  Future<void> testServerConnection() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000'));  // Flask 서버에 요청
      if (response.statusCode == 200) {
        // 서버로부터 응답 성공 시
        setState(() {
          message = json.decode(response.body)['message'];  // 서버의 메시지를 화면에 표시
        });
      } else {
        // 서버 응답 실패 시
        setState(() {
          message = 'Failed to connect to the server. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      // 요청 도중 에러가 발생한 경우
      setState(() {
        message = 'Error connecting to the server: $e';
      });
    }
  }

  // 하단 네비게이션 아이템 클릭 시 호출되는 함수
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // 선택된 인덱스를 업데이트
    });
  }

  // 선택된 인덱스에 따라 페이지를 반환하는 함수
  Widget _buildPage(int index) {
    switch (index) {
      case 0: return DolScreen(); // 첫 번째 페이지
      case 1: return HashScreen(onKeywordSelected: _onItemTapped); // 두 번째 페이지
      case 2: return BriefcaseScreen(); // 세 번째 페이지
      case 3: return MenuScreen(); // 네 번째 페이지
      case 11: return HashDetail(onKeywordSelected: _onItemTapped);
      default: return Container(); // 기본값 (빈 컨테이너)
    }
  }

  // 아이콘 생성 함수
  Widget _buildIcon(String assetName, int index, {double width = 36, double height = 36}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index), // 아이콘 클릭 시 탭 인덱스 변경
      child: SvgPicture.asset(
        assetName, // SVG 아이콘 경로
        color: _currentIndex == index || _currentIndex == index+10 ? Color(0xFF477C59) : Color(0xFF284029), // 선택된 상태에 따라 색상 변경
        width: width,
        height: height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _onBackPressed(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white, // 배경색 설정
        body: _buildPage(_currentIndex), // 현재 선택된 페이지 표시
        // body: Text(message, style: TextStyle(fontSize: 20),),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFFF8F8F8), // 하단 네비게이션 바 색상
          height: 100, // 높이 설정
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
            children: <Widget>[
              _buildIcon('assets/icons/Dol.svg', 0, width: 32, height: 60), // 첫 번째 아이콘
              SizedBox(width: 60), // 아이콘 사이 간격
              _buildIcon('assets/icons/Hash.svg', 1), // 두 번째 아이콘
              SizedBox(width: 60), // 아이콘 사이 간격
              _buildIcon('assets/icons/Briefcase.svg', 2), // 세 번째 아이콘
              SizedBox(width: 60), // 아이콘 사이 간격
              _buildIcon('assets/icons/Menu.svg', 3), // 네 번째 아이콘
              SizedBox(width: 10), // 아이콘 사이 간격
            ],
          ),
        ),
      ),
    );
  }
}
