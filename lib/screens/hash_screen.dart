import 'package:flutter/material.dart';
import 'package:obsser_1/screens/hash/hash_detail.dart';
import 'package:obsser_1/screens/hash/hash_detail_type.dart';
import 'package:obsser_1/screens/search_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  bool isLoading = true; // 로딩 상태를 표시하는 변수
  List<Map<String, String>> places = []; // 서버에서 받아온 여행지 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // 게시판용 페이지 컨트롤러 초기화
    fetchPlacesData(); // 페이지 로드 시 서버에서 데이터 가져오기
  }

  /* ### 서버에서 여행지 데이터를 받아오는 함수 ### */
Future<void> fetchPlacesData() async {
  final response = await http.get(Uri.parse('http://3.37.197.251:5000/place_pages'));

  if (response.statusCode == 200) {
    // 응답 성공시, 데이터를 파싱하고 Map<String, String>으로 변환
    Map<String, dynamic> data = json.decode(response.body)['data'];
    List<Map<String, String>> travelData = [ // 리스트로 감쌈
      {
        'current_weather': data['current_weather'].toString(),
        'name': data['name'].toString(),
        'image': data['image'].toString(),
      }
    ];

    setState(() {
      places = travelData; // 받아온 데이터를 places에 저장
      isLoading = false; // 로딩 상태 해제
    });
  } else {
    throw Exception('Failed to load travel data');
  }
}


  /* ### 리소스 해제 메서드 ### */
  @override
  void dispose() {
    _pageController.dispose(); // 게시판용 페이지 컨트롤러 해제
    super.dispose();
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
        padding: const EdgeInsets.fromLTRB(38, 15, 38, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
            children: [
              buildKeywordHeader(), // 키워드 검색 헤더 위젯
              const SizedBox(height: 5),
              buildKeywordChips(), // 키워드 칩 리스트 위젯
              const SizedBox(height: 20),

              buildTitle('오늘의 날씨', ', 오늘의 여행'), // 카테고리별 여행지 제목
              const SizedBox(height: 5),
              
              // 서버에서 가져온 데이터를 로딩 중일 때와 로딩 후에 각각 처리
              // 서버에서 가져온 데이터를 로딩 중일 때와 로딩 후에 각각 처리
              isLoading
                ? const Center(child: CircularProgressIndicator()) // 로딩 중일 때 인디케이터 표시
                : Column(
                    children: places.map((place) {
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 10), // 카드 간격 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // 카드 모서리 둥글게 설정
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 이미지 표시
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), // 이미지의 모서리 둥글게
                              child: Image.memory(
                                base64Decode(place['image']!), // Base64로 디코딩된 이미지
                                fit: BoxFit.cover,
                                height: 200, // 이미지 높이 크게 설정
                                width: double.infinity, // 가로로 꽉 채우기
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0), // 텍스트 패딩 설정
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place['name']!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8), // 텍스트 간격
                                  Text(
                                    '${place['current_weather']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
        // Container(
        //   padding: const EdgeInsets.fromLTRB(0, 2, 20, 0),
        //   width: 155,
        //   height: 30,
        //   child: TextField(
        //     controller: _searchController, // 검색창 컨트롤러 연결
        //     decoration: InputDecoration(
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(20),
        //         borderSide: BorderSide.none, // 테두리 없음
        //       ),
        //       filled: true,
        //       fillColor: const Color(0xFFF2F2F2), // 배경색 회색
        //       suffixIcon: IconButton(
        //         padding: EdgeInsets.zero,
        //         icon: const Icon(Icons.search, size: 28, color: Color(0xFF000000)),
        //         onPressed: () {
        //           // 검색 버튼 클릭 시 SearchScreen으로 입력값 전달
        //           String query = _searchController.text;
        //           if (query.isNotEmpty) {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => SearchScreen(query: query), // 검색어를 SearchScreen으로 전달
        //               ),
        //             );
        //           }
        //         },
        //       ),
        //       suffixIconConstraints: const BoxConstraints(
        //         maxWidth: 30,
        //       ),
        //       contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0), // 수직 패딩 조정
        //     ),
        //   ),
        // ),
      ],
    );
  }

  /* ##### 키워드 칩 리스트 ##### */
  Widget buildKeywordChips() {
    List<String> keywords = ['한적한', '감성적인', '휴양지', '맛집', '야경', '여유로운', '술', '촬영지', '드라이브'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 175, // 칩 리스트 높이
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
                  '#${keywords[index]}',
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
                bottom: 5,
                child: IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  onPressed: () {
                    // 카테고리 버튼 클릭 시 동작
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HashDetailT(
                        selectedKeyword: category['label']!,
                        onKeywordSelected: widget.onKeywordSelected,
                      ),
                    ),
                  );
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
