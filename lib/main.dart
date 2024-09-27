import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/dol_screen.dart';
import 'screens/hash_screen.dart';
import 'screens/briefcase_screen.dart';
import 'screens/menu_screen.dart';

void main(){
  runApp(MyApp());
}

/* ##### 앱 종료할지 묻는 팝업 ##### */
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

/* ##### 앱 설정 ##### */
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard',), // 기본 폰트: Pretendard
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      home: const MainPage(), // 메인 페이지 설정
    );
  }
}

/* ##### 메인 페이지 ##### */
class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({this.initialIndex=0});

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // 현재 선택된 네비게이션 버튼 인덱스

  /**### 페이지 로드 시 실행 ### */
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // 초기 인덱스
  }

  /* ### 네비게이션 버튼 클릭 함수 ### */
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // 선택된 인덱스 업데이트
    });
  }

  /* ### 선택된 인덱스로 페이지 반환 위젯 ### */
  Widget _buildPage(int index) {
    switch (index) {
      case 0: return DolScreen(); // 메인 홈 페이지
      case 1: return HashScreen(onKeywordSelected: _onItemTapped); // 여행지 키워드 페이지
      case 2: return BriefcaseScreen(); // 여행 일정 페이지
      case 3: return MenuScreen(); // 메뉴 페이지
      default: return Container(); // 기본값(빈 컨테이너)
    }
  }

  /* ### 네비게이션 버튼 생성 위젯 ### */
  Widget _buildIcon(String assetName, int index, {double width = 36, double height = 36}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index), // 클릭 시 탭 인덱스 변경
      child: SvgPicture.asset(
        assetName, // SVG 아이콘 경로
        colorFilter: ColorFilter.mode(
          _currentIndex == index || _currentIndex == index + 10 ? const Color(0xFF477C59) : const Color(0xFF284029), 
          BlendMode.srcIn
        ), // 선택된 상태에 따라 색상 변경
        width: width,
        height: height,
      ),
    );
  }

  /* ### 메인 페이지 return ### */
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope( // 뒤로가기 버튼 눌렀을 때 실행
      onWillPop: () async {
        await _onBackPressed(context); // 앱을 종료할지 묻는 팝업
        return false;
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
              _buildIcon('assets/icons/Hash.svg', 1), // 여행지 키워드 아이콘
              const SizedBox(width: 60),
              _buildIcon('assets/icons/Briefcase.svg', 2), // 여행 일정 아이콘
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
