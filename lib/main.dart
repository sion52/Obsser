import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/dol_screen.dart';
import 'screens/hash_screen.dart';
import 'screens/briefcase_screen.dart';
import 'screens/menu_screen.dart';

void main() async {
  runApp(const MyApp());
}

/* ##### 앱 종료 확인 팝업 ##### */
Future<void> _onBackPressed(BuildContext context) async {
  
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFFFFFFFF),
      title: const Text('옵써를 종료하시겠습니까?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text('확인'),
        ),
      ],
    ),
  );
}

/* ##### 앱 메인 설정 ##### */
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard', // 기본 폰트 설정
      ),
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      home: const MainPage(), // 메인 페이지 지정
    );
  }
}

/* ##### 메인 페이지 ##### */
class MainPage extends StatefulWidget {
  final int initialIndex; // 초기 네비게이션 인덱스

  const MainPage({super.key, this.initialIndex = 0}); // 기본값을 0으로 설정

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // 현재 선택된 네비게이션 인덱스

  /* ### 초기 상태 설정 ### */
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // 초기 페이지 설정
  }

  /* ### 네비게이션 버튼 클릭 시 실행 ### */
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // 선택된 인덱스 업데이트
    });
  }

  /* ### 인덱스에 따라 페이지 반환 ### */
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const DolScreen(); // 메인 홈 페이지
      case 1:
        return HashScreen(onKeywordSelected: _onItemTapped); // 키워드 페이지
      case 2:
        return const BriefcaseScreen(); // 일정 페이지
      case 3:
        return const MenuScreen(); // 메뉴 페이지
      default:
        return Container(); // 기본 빈 컨테이너
    }
  }

  /* ### 하단 네비게이션 아이콘 생성 ### */
  Widget _buildIcon(String assetName, int index, {double width = 36, double height = 36}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index), // 아이콘 클릭 시 페이지 변경
      child: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(
          _currentIndex == index ? const Color(0xFF477C59) : const Color(0xFF284029),
          BlendMode.srcIn,
        ), // 선택된 상태에 따라 색상 변경
        width: width,
        height: height,
      ),
    );
  }

  /* ### 메인 화면 생성 ### */
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        await _onBackPressed(context); // 뒤로가기 시 앱 종료 확인 팝업
        return false; // 팝업 이후 동작 방지
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildPage(_currentIndex), // 현재 선택된 페이지 표시
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFF8F8F8), // 하단 네비게이션 바 색상
          height: 90, // 높이 설정
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
            children: <Widget>[
              _buildIcon('assets/icons/Dol.svg', 0, width: 32, height: 60), // 메인 홈 아이콘
              const SizedBox(width: 60),
              _buildIcon('assets/icons/Hash.svg', 1), // 키워드 아이콘
              const SizedBox(width: 60),
              _buildIcon('assets/icons/Briefcase.svg', 2), // 일정 아이콘
              const SizedBox(width: 60),
              _buildIcon('assets/icons/Menu.svg', 3), // 메뉴 아이콘
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
