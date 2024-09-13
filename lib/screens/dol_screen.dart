import 'package:flutter/material.dart';
import 'dart:async';
import 'package:obsser_1/screens/dol_detail.dart';
import 'package:obsser_1/screens/magazine_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DolScreen extends StatefulWidget {
  @override
  _DolScreenState createState() => _DolScreenState();
}

class _DolScreenState extends State<DolScreen> {
  String dolMessage = 'Loading...'; // 서버 응답 메세지 저장 변수

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

    fetchDolData(); // 페이지 로드 시 서버에 데이터 요청

    _pageController = PageController(); // 페이지 컨트롤러 초기화
    // 페이지 변경 시 현재 페이지 업데이트
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _startAutoSlide(); // 자동 슬라이드 시작
  }

  Future<void> fetchDolData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/dol'));
      if (response.statusCode == 200) {
        // 서버 응답 성공시
        setState(() {
          dolMessage = json.decode(response.body)['dolMessage'];
        });
      } else {
        // 서버 응답 실패시
        setState(() {
          dolMessage = 'Failed to fetch data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      // 오류 발생시
      setState(() {
        dolMessage = 'Error fetching data: $e';
      });
    }
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
        duration: Duration(milliseconds: 500), // 애니메이션 지속 시간
        curve: Curves.easeInOut, // 애니메이션 곡선
      );
    });
  }

  void _onImageTap(int index) {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => DolDetail(imageIndex: index,))
    );
  }
  
  void _onMagazineTap(int index) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => MagzScreen(index: index),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 슬라이드 배너
          Stack(
            children: [
              Container(
                height: 470, // 배너의 높이
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length, // 이미지 수
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onImageTap(index),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 3,
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
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  onPressed: () {

                  }, 
                  icon: Icon(
                    Icons.notifications_none,
                    size: 50,
                    color: Color(0xFF000000),
                  )),
              )
            ],
          ),
          // 검색창
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 130, // 검색창 높이
              decoration: BoxDecoration(
                color: Color(0xFFEFEFEF), // 배경색
                borderRadius: BorderRadius.circular(15), // 모서리 둥글게
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                    child: Text(
                      '어떤 여행지를 찾으시나요?', // 질문 텍스트
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900, // 굵은 텍스트
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F9FE), // 검색창 배경색
                        borderRadius: BorderRadius.circular(30.0), // 모서리 둥글게
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.1), // 그림자 색상
                        //     blurRadius: 10.0, // 흐림 정도
                        //     spreadRadius: 2.0, // 확산 정도
                        //   ),
                        // ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none, // 테두리 없음
                          hintText: ' 검색', // 힌트 텍스트
                          hintStyle: TextStyle(fontSize: 18, color: Colors.grey), // 힌트 색상
                          prefixIcon: Icon(Icons.search, color: Color(0xFF000000)), // 검색 아이콘
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 매거진 섹션
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 1125, // 창 높이
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFE8F1EA), // 배경색
                borderRadius: BorderRadius.circular(15), // 모서리 둥글게
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 18, 0, 5),
                        child: Text(
                          '옵써의 트렌디한 매거진', // 텍스트
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 18, 16, 5),
                        child: Text(
                          '더보기', // 텍스트
                          style: TextStyle(
                            color: Color(0xFF477C59),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () => _onMagazineTap(0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/magazines/m_0.png'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () => _onMagazineTap(1),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/magazines/m_1.png'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () => _onMagazineTap(2),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/magazines/m_2.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25,),
          Text(dolMessage, style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}
