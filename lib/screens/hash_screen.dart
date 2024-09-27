import 'package:flutter/material.dart';
import 'package:obsser_1/screens/hash/hash_detail.dart';

/* ##### 키워드 검색 및 카테고리 선택 페이지 ##### */
class HashScreen extends StatefulWidget {
  final Function(int) onKeywordSelected;

  const HashScreen({super.key, required this.onKeywordSelected});

  @override
  State<HashScreen> createState() => _HashScreenState();
}

class _HashScreenState extends State<HashScreen> {
  String? selectedKeyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // AppBar 배경색 흰색
        toolbarHeight: 0, // 툴바 높이 0으로 설정
      ),
      backgroundColor: const Color(0xFFFFFFFF), // 페이지 배경색 흰색
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38, 50, 38, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
            children: [
              buildKeywordHeader(), // 키워드 검색 헤더 위젯
              const SizedBox(height: 8),
              buildKeywordChips(), // 키워드 칩 리스트 위젯
              const SizedBox(height: 40),
              buildTransportTitle(), // 교통수단별 여행코스 제목
              const SizedBox(height: 10),
              buildTransportOptions(), // 교통수단 선택 위젯
              const SizedBox(height: 40),
              buildCategoryTitle(), // 카테고리별 여행지 제목
              const SizedBox(height: 16),
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
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none, // 테두리 없음
              ),
              filled: true,
              fillColor: const Color(0xFFE0E0E0), // 배경색 회색
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.search, size: 28, color: Color(0xFF000000)),
                onPressed: () {
                  // 검색 버튼 클릭 시 동작
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
          color: const Color(0xFFFFFFFF), // 배경색 흰색
          borderRadius: BorderRadius.circular(20), // 모서리 둥글게
          border: Border.all(width: 1, color: const Color(0xA6A4A4A4)) // 테두리 색
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
                      )
                    )
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

  /* ##### 교통수단별 여행코스 제목 ##### */
  Widget buildTransportTitle() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '교통수단별',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
          ),
          TextSpan(
            text: ' 여행코스',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    );
  }

  /* ##### 교통수단 선택 위젯 ##### */
  Widget buildTransportOptions() {
    // 교통수단 리스트
    List<Map<String, dynamic>> transportOptions = [
      {'icon': Icons.directions_car, 'label': '자동차'},
      {'icon': Icons.pedal_bike, 'label': '자전거'},
      {'icon': Icons.directions_walk, 'label': '도보'},
      {'icon': Icons.directions_bus, 'label': '버스'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: transportOptions.map((option) {
        return Column(
          children: [
            // 교통수단 아이콘 원형 배경
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE8E9F1), // 배경색
              ),
              child: Center(
                child: Icon(option['icon'], size: 40, color: const Color(0xFF284029)), // 아이콘
              ),
            ),
            const SizedBox(height: 3),
            Text(option['label'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)), // 라벨
          ],
        );
      }).toList(),
    );
  }

  /* ##### 카테고리별 여행지 제목 ##### */
  Widget buildCategoryTitle() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '카테고리별',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
          ),
          TextSpan(
            text: ' 여행지',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
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
