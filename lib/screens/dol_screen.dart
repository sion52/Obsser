import 'package:flutter/material.dart';
import 'dart:async';

class DolScreen extends StatefulWidget {
  @override
  _DolScreenState createState() => _DolScreenState();
}

class _DolScreenState extends State<DolScreen> {
  // 이미지 목록
  final List<String> images = [
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];

  late PageController _pageController; // 페이지 컨트롤러
  int _currentPage = 0; // 현재 페이지 인덱스
  Timer? _timer; // 자동 슬라이드를 위한 타이머

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // 페이지 변경 시 현재 페이지 업데이트
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _startAutoSlide(); // 자동 슬라이드 시작
  }

  @override
  void dispose() {
    _pageController.dispose(); // 페이지 컨트롤러 해제
    _timer?.cancel(); // 타이머 해제
    super.dispose();
  }

  // 자동 슬라이드를 위한 메서드
  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % images.length; // 다음 페이지로 이동
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut, // 애니메이션 효과
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 450, // 배너의 높이
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length, // 이미지 수
                  itemBuilder: (context, index) {
                    return Image.asset(
                      images[index], // 이미지 표시
                      fit: BoxFit.cover, // 이미지를 커버로 맞춤
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return Container(
                      margin: EdgeInsets.all(4.0), // 점 간격
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // 원형으로 표시
                        color: _currentPage == index
                            ? Color(0xFF85C59A) // 현재 페이지 색상
                            : Color(0xFFFFFFFF), // 비활성 페이지 색상
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 140, // 검색창 높이
              decoration: BoxDecoration(
                color: Color(0xFFEFEFEF), // 배경색
                borderRadius: BorderRadius.circular(15), // 모서리 둥글게
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      '어떤 여행지를 찾으시나요?', // 질문 텍스트
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold, // 굵은 텍스트
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F9FE), // 검색창 배경색
                        borderRadius: BorderRadius.circular(30.0), // 모서리 둥글게
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // 그림자 색상
                            blurRadius: 10.0, // 흐림 정도
                            spreadRadius: 2.0, // 확산 정도
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none, // 테두리 없음
                          hintText: '검색', // 힌트 텍스트
                          hintStyle: TextStyle(color: Colors.grey), // 힌트 색상
                          prefixIcon: Icon(Icons.search, color: Colors.grey), // 검색 아이콘
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
