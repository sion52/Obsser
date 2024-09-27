import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obsser_1/screens/dol/dol_detail.dart';
import 'package:obsser_1/screens/dol/magazine_detail.dart';
import 'package:obsser_1/screens/menu/notice.dart';

/* ##### 메인 홈 페이지 ##### */
class DolScreen extends StatefulWidget {
  const DolScreen({super.key});

  @override
  State<DolScreen> createState() => _DolScreenState();
}

class _DolScreenState extends State<DolScreen> {
  String dolMessage = 'Loading...'; // 서버 응답 메시지 저장 변수
  late PageController _pageController; // 페이지 슬라이드 컨트롤러
  int _currentSlide = 0; // 현재 슬라이드 인덱스 저장 변수
  Timer? _timer; // 자동 슬라이드를 위한 타이머

  final List<String> images = [ // 슬라이드 이미지 리스트
    'assets/banners/banner1.png',
    'assets/banners/banner2.png',
    'assets/banners/banner3.png',
    'assets/banners/banner4.png',
  ];

  /* ### 초기화 메서드 ### */
  @override
  void initState() {
    super.initState();

    fetchDolData(); // 페이지 로드 시 서버에서 데이터 요청
    _pageController = PageController(); // 페이지 컨트롤러 초기화
    
    // 페이지 변경 시 현재 슬라이드 인덱스 업데이트
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentSlide = _pageController.page!.round();
        });
      }
    });

    _startAutoSlide(); // 자동 슬라이드 시작
  }

  /* ### 서버 데이터 요청 메서드 ### */
  Future<void> fetchDolData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/'));
      if (mounted && response.statusCode == 200) { // 서버 응답이 성공적일 경우
        setState(() {
          dolMessage = json.decode(response.body)['dolMessage']; // 서버 응답 메시지 반영
        });
      } else if (mounted) { // 서버 응답 실패
        setState(() {
          dolMessage = 'Failed to fetch data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) { // 오류 처리
      if (mounted) {
        setState(() {
          dolMessage = 'Error fetching data: $e';
        });
      }
    }
  }

  /* ### 리소스 해제 메서드 ### */
  @override
  void dispose() {
    _pageController.dispose(); // 페이지 컨트롤러 해제
    _timer?.cancel(); // 타이머 해제
    super.dispose();
  }

  /* ### 자동 슬라이드 메서드 ### */
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) { // 3초마다 슬라이드 전환
      if (!mounted) return;
      setState(() {
        _currentSlide = (_currentSlide + 1) % images.length; // 다음 슬라이드로 이동
      });
      _pageController.animateToPage(
        _currentSlide,
        duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
        curve: Curves.easeInOut, // 애니메이션 효과
      );
    });
  }

  /* ### 슬라이드 이미지 클릭 이벤트 처리 ### */
  void _onImageTap(int index) {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => DolDetail(imageIndex: index,), // 클릭한 슬라이드 인덱스 전달
      )
    );
  }

  /* ### 매거진 이미지 클릭 이벤트 처리 ### */
  void _onMagazineTap(int index) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => MagzScreen(index: index), // 클릭한 매거진 인덱스 전달
      ),
    );
  }

  /* ### 메인 페이지 UI 구성 ### */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 0, // 툴바 높이 설정
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 전체 배경색 설정
      body: SingleChildScrollView( // 페이지 전체를 스크롤 가능하도록 설정
        child: Column(
          children: [
            /* ### 이미지 슬라이드 섹션 ### */
            Stack(
              children: [
                SizedBox( // 슬라이드 이미지 컨테이너
                  height: 470,
                  child: PageView.builder(
                    controller: _pageController, // 페이지 컨트롤러 연결
                    itemCount: images.length, // 이미지 개수
                    itemBuilder: (context, index) {
                      return GestureDetector( // 이미지 클릭 이벤트
                        onTap: () => _onImageTap(index), // 클릭 시 상세 페이지로 이동
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover, // 이미지 화면에 맞추기
                        ),
                      );
                    },
                  ),
                ),
                Positioned( // 슬라이드 도트 표시
                  bottom: 3,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(images.length, (index) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // 원형 도트
                          color: _currentSlide == index ? const Color(0xFF85C59A) : const Color(0xFFFFFFFF), // 현재 슬라이드 색상
                        ),
                      );
                    }),
                  ),
                ),
                Positioned( // 알림 아이콘 (오른쪽 상단)
                  top: 30,
                  right: 30,
                  child: GestureDetector(
                    onTap: () => Navigator.push( // 알림 페이지로 이동
                      context, 
                      MaterialPageRoute(
                        builder: (context) => const NoticeScreen(), // 알림 페이지
                      ),
                    ),
                    child: SvgPicture.asset('assets/icons/Bell.svg',), // 알림 아이콘
                  ),
                ),
              ],
            ),

            /* ### 검색 섹션 ### */
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 130,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 15, 16, 0),
                      child: Text(
                        '어떤 여행지를 찾으시나요?', // 질문 텍스트
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FE),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' 검색',
                            hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF8F9098)),
                            prefixIcon: Icon(Icons.search, color: Color(0xFF000000)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /* ### 매거진 섹션 ### */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 1120,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1EA),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 18, 0, 0),
                      child: Text(
                        '옵써의 트렌디한 매거진',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        )
                      ),
                    ),
                    _buildMagazineCard(0, 'assets/magazines/m_0.png'), // 첫 번째 매거진 카드
                    _buildMagazineCard(1, 'assets/magazines/m_1.png'), // 두 번째 매거진 카드
                    _buildMagazineCard(2, 'assets/magazines/m_2.png'), // 세 번째 매거진 카드
                  ],
                ),
              ),
            ),

            /* 화면 아래 여백 */
            const SizedBox(height: 25,),

            /* 서버 요청 응답 메시지 */
            Center(
              child: Text(
                dolMessage,
                style: const TextStyle(fontSize: 12, color: Color(0xFFE0E0E0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  /* ### 매거진 카드 생성 메서드 ### */
  Widget _buildMagazineCard(int index, String imagePath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: GestureDetector(
        onTap: () => _onMagazineTap(index), // 매거진 클릭 이벤트
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath), // 매거진 이미지 경로
          ),
        ),
      ),
    );
  }
}
