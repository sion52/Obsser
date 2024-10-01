import 'package:flutter/material.dart';
import 'package:obsser_1/screens/hash/hash_detail.dart';
import 'package:obsser_1/screens/search_screen.dart';

/* ##### 키워드 검색 및 카테고리 선택 페이지 ##### */
class HashScreen extends StatefulWidget {
  final Function(int) onKeywordSelected;

  const HashScreen({super.key, required this.onKeywordSelected});

  @override
  State<HashScreen> createState() => _HashScreenState();
}

class _HashScreenState extends State<HashScreen> {
  String? selectedKeyword;
  final TextEditingController _searchController = TextEditingController(); // 검색창 컨트롤러 추가
  late PageController _pageController;

  final List<Map<String, String>> posts = [
    {
      'title': '카멜리아 힐',
      'description': '따뜻한 제주를 맘껏 즐기는건 어때요?',
      'imageUrl': 'assets/pictures/camellia.png',
    },
    {
      'title': '두 번째 게시물',
      'description': '이것은 두 번째 게시물입니다.',
      'imageUrl': 'assets/pictures/camellia.png',
    },
    {
      'title': '세 번째 게시물',
      'description': '이것은 세 번째 게시물입니다.',
      'imageUrl': 'assets/pictures/camellia.png',
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();  // 게시판용 페이지 컨트롤러 초기화
  }

  /* ### 리소스 해제 메서드 ### */
  @override
  void dispose() {
    _pageController.dispose();  // 게시판용 페이지 컨트롤러 해제
    super.dispose();
  }

  /* ### 슬라이드 게시판 카드 생성 메서드 ### */
  Widget _buildPostCard(Map<String, String> post) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 배경색 흰색
          borderRadius: BorderRadius.circular(15), // 모서리 둥글게
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // 그림자 색상 및 투명도
              spreadRadius: 1, // 그림자가 퍼지는 정도
              blurRadius: 3, // 그림자 블러 정도
              offset: const Offset(0, 3), // 그림자의 위치
            ),
          ],
        ),
        clipBehavior: Clip.none, // 그림자가 짤리지 않도록 설정
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                post['imageUrl']!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,10,16,16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    post['description']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // AppBar 배경색 흰색
        toolbarHeight: 0, // 툴바 높이 0으로 설정
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 페이지 배경색 흰색
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38, 30, 38, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
            children: [
              buildKeywordHeader(), // 키워드 검색 헤더 위젯
              const SizedBox(height: 5),
              buildKeywordChips(), // 키워드 칩 리스트 위젯
              const SizedBox(height: 20),

              buildTitle('오늘의 추천', ' 여행지'), // 카테고리별 여행지 제목
              const SizedBox(height: 5),
              /* ### 슬라이드 게시판 섹션 추가 ### */
              SizedBox(
                height: 300, // 슬라이드 게시판 높이 설정
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return _buildPostCard(posts[index]); // 슬라이드 게시판 내용
                  },
                ),
              ),
              const SizedBox(height: 10),
              
              buildTitle('카테고리별', ' 여행지'), // 카테고리별 여행지 제목
              const SizedBox(height: 3),
              buildCategoryList(), // 카테고리 리스트 위젯
            ],
          ),
        ),
      ),
    );
  }

  /* ##### 키워드별 여행지 헤더 ##### */
  Widget buildKeywordHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // "키워드별 여행지" 텍스트
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '키워드별',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
              ),
              TextSpan(
                text: ' 여행지',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
        ),
        // 검색 입력 필드
        Container(
          padding: const EdgeInsets.fromLTRB(0, 2, 20, 0),
          width: 155,
          height: 30,
          child: TextField(
            controller: _searchController, // 검색창 컨트롤러 연결
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none, // 테두리 없음
              ),
              filled: true,
              fillColor: const Color(0xFFF2F2F2), // 배경색 회색
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.search, size: 28, color: Color(0xFF000000)),
                onPressed: () {
                  // 검색 버튼 클릭 시 SearchScreen으로 입력값 전달
                  String query = _searchController.text;
                  if (query.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(query: query), // 검색어를 SearchScreen으로 전달
                      ),
                    );
                  }
                },
              ),
              suffixIconConstraints: const BoxConstraints(
                maxWidth: 30,
              ),
              contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0), // 수직 패딩 조정
            ),
          ),
        ),
      ],
    );
  }

  /* ##### 키워드 칩 리스트 ##### */
  Widget buildKeywordChips() {
    List<String> keywords = ['#한적한', '#감성적인', '#휴양지', '#맛집', '#야경', '#여유로운', '#술', "#촬영지", "#드라이브"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 185, // 칩 리스트 높이
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA), // 배경색 흰색
          borderRadius: BorderRadius.circular(20), // 모서리 둥글게
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          )],
        ),
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(7, 14, 7, 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3개의 열
            childAspectRatio: 2, // 칩 비율 설정
          ),
          itemCount: keywords.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: ElevatedButton(
                onPressed: () {
                  // 키워드 클릭 시 HashDetail로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HashDetail(
                        selectedKeyword: keywords[index],
                        onKeywordSelected: widget.onKeywordSelected,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: const Color(0xFFE8F1EA), // 버튼 배경색
                  foregroundColor: const Color(0xFF000000), // 텍스트 색
                  elevation: 0, // 그림자 없음
                ),
                child: Text(
                  keywords[index],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /* ##### 여행코스 제목 ##### */
  Widget buildTitle(String a, String b) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: a,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
          ),
          TextSpan(
            text: b,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    );
  }

  /* ##### 카테고리 리스트 위젯 ##### */
  Widget buildCategoryList() {
    // 카테고리 리스트
    List<Map<String, String>> categories = [
      {'label': '식당', 'image': 'assets/buttons/back_1.png'},
      {'label': '카페', 'image': 'assets/buttons/back_2.png'},
      {'label': '명소', 'image': 'assets/buttons/back_3.png'}
    ];

    return Column(
      children: categories.map((category) {
        return Container(
          width: double.infinity,
          height: 35,
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFE8E9F1), // 배경색
            image: DecorationImage(
              image: AssetImage(category['image']!), // 배경 이미지
              fit: BoxFit.cover,
            ),
            boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  category['label']!, // 카테고리 라벨
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              // 오른쪽 화살표 아이콘 버튼
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  onPressed: () {
                    // 카테고리 버튼 클릭 시 동작
                  }, 
                  icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF000000), size: 20),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
