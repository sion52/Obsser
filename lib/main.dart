import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

void main() {
  runApp(MyApp()); // 앱 시작
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 숨김
      home: MainPage(), // 메인 페이지 설정
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState(); // 상태 생성
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // 탭 선택 시 인덱스 업데이트
    });
  }

  Widget _buildPage(int index) {
    // 선택된 인덱스에 따라 다른 페이지 반환
    switch (index) {
      case 0: return DolScreen();
      case 1: return HashScreen();
      case 2: return BriefcaseScreen();
      case 3: return MenuScreen();
      default: return Container(); // 기본값
    }
  }

  Widget _buildIcon(String assetName, int index, {double width = 32, double height = 32}) {
    // 아이콘을 생성하는 메서드
    return GestureDetector(
      onTap: () => _onItemTapped(index), // 아이콘 클릭 시 탭 변경
      child: SvgPicture.asset(
        assetName,
        color: _currentIndex == index ? Color(0xFF477C59) : Color(0xFF284029), // 선택된 탭 색상 변경
        width: width,
        height: height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: _buildPage(_currentIndex), // 현재 페이지 표시
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFF8F8F8), // 하단 내비게이션 바 색상
        height: 80, // 높이
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          children: <Widget>[
            _buildIcon('assets/icons/Dol.svg', 0, width: 90, height: 90), // 첫 번째 아이콘
            SizedBox(width: 50), // 간격
            _buildIcon('assets/icons/Hash.svg', 1), // 두 번째 아이콘
            SizedBox(width: 60), // 간격
            _buildIcon('assets/icons/Briefcase.svg', 2), // 세 번째 아이콘
            SizedBox(width: 60), // 간격
            _buildIcon('assets/icons/Menu.svg', 3), // 네 번째 아이콘
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

/* 메인 화면 */
class DolScreen extends StatefulWidget {
  @override
  _DolScreenState createState() => _DolScreenState(); // 상태 생성
}

class _DolScreenState extends State<DolScreen> {
  final List<String> images = [ // 슬라이드 이미지 파일
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];

  PageController _pageController = PageController(); // 페이지 컨트롤러
  int _currentPage = 0; // 현재 페이지 인덱스
  Timer? _timer; // Timer 변수

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round(); // 페이지 변화에 따라 현재 페이지 업데이트
      });
    });

    // 자동 슬라이드 기능
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose(); // 페이지 컨트롤러 해제
    _timer?.cancel(); // 타이머 해제
    super.dispose();
  }

  void _startAutoSlide() { // 3초마다 페이지 변경
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container( // 이미지 슬라이드
          height: 400, // 배너 높이
          child: PageView.builder(
            controller: _pageController, // 페이지 컨트롤러 설정
            itemCount: images.length, // 이미지 개수
            itemBuilder: (context, index) {
              return Image.asset(
                images[index], // 이미지 표시
                fit: BoxFit.cover, // 이미지 비율 유지
              );
            },
          ),
        ),
        Positioned( // 이미지 슬라이드 도트
          bottom: 10, // 하단 위치
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
            children: List.generate(images.length, (index) {
              return Container(
                margin: EdgeInsets.all(4.0), // 아이콘 간격
                width: 8.0, // 아이콘 너비
                height: 8.0, // 아이콘 높이
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // 원형 아이콘
                  color: _currentPage == index ? Color(0xFF85C59A) : Color(0xFFFFFFFF), // 현재 페이지에 따라 색상 변경
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/* 키워드 검색 화면 */
class HashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Hash 화면', style: TextStyle(fontSize: 24)), // Hash 화면 텍스트
    );
  }
}

/* 여행 화면 */
class BriefcaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Briefcase 화면', style: TextStyle(fontSize: 24)), // Briefcase 화면 텍스트
    );
  }
}

/* 메뉴 화면 */
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Menu 화면', style: TextStyle(fontSize: 24)), // Menu 화면 텍스트
    );
  }
}
