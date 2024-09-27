import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:obsser_1/screens/hash/hash_detail_route.dart';

/* ##### 키워드별 여행지 화면 ##### */
class HashDetail extends StatefulWidget {
  final Function(int) onKeywordSelected; // 선택된 키워드에 대한 콜백
  final String selectedKeyword; // 선택된 키워드

  const HashDetail({super.key, required this.selectedKeyword, required this.onKeywordSelected});

  @override
  State<HashDetail> createState() => _HashDetailState();
}

class _HashDetailState extends State<HashDetail> {
  List<bool> isFavoriteList = [false, false, false, false]; // 각 카드의 즐겨찾기 상태 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 16), // 패딩 설정
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
              children: [
                buildKeywordHeader(), // 키워드별 여행지 제목
                const SizedBox(height: 8),
                buildKeywordChips(), // 키워드 칩 및 카드 리스트
              ],
            ),
          ),
          /* ### 여행 루트 문구 및 버튼 ### */
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
              children: [
                const Text(
                  '옵써가 계획한 ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF000000)),
                ),
                Text(
                  widget.selectedKeyword, // 선택한 키워드 표시
                  style: const TextStyle(fontSize: 16, color: Color(0xFF497F5B)),
                ),
                const Text(
                  ' 여행루트는 어때요? ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF000000)),
                ),
                GestureDetector(
                  onTap: () {
                    // 여행루트 상세 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HashDetailRoute(selectedKeyword: widget.selectedKeyword)),
                    );
                  },
                  child: const Text(
                    '보러가기>',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF497F5B)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* ### 키워드별 여행지 제목 ### */
  Widget buildKeywordHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
      children: [
        Text.rich(
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
      ],
    );
  }

  /* ### 키워드 칩 및 여행지 카드 리스트 ### */
  Widget buildKeywordChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0), // 가로 패딩 0
      child: Container(
        height: 660, // 전체 컨테이너 높이
        width: double.infinity, // 가로는 화면 전체 크기
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF), // 배경색 흰색
          borderRadius: BorderRadius.circular(20), // 둥근 모서리
          border: Border.all(width: 1, color: const Color(0xA6A4A4A4)), // 테두리
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 0), // 내부 패딩 설정
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
                children: [
                  /* ### 키워드 버튼 ### */
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0), // 패딩 설정
                    child: ElevatedButton(
                      onPressed: () {
                        // 선택된 키워드를 전달하며 페이지 종료
                        Navigator.pop(context, widget.selectedKeyword);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0), // 버튼 내부 패딩
                        backgroundColor: const Color(0xFFD9D9D9), // 버튼 배경색
                        foregroundColor: const Color(0xFF000000), // 버튼 텍스트 색상
                        elevation: 0, // 그림자 없음
                        minimumSize: const Size(110, 50), // 버튼 크기 설정
                      ),
                      child: Text(
                        widget.selectedKeyword, // 선택된 키워드 표시
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  /* ### 여행지 카드 리스트 ### */
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildCard(0, '카멜리아 힐', 'assets/pictures/camellia.png'),
                          const SizedBox(height: 5),
                          _buildCard(1, '생각하는 정원', 'assets/pictures/garden.png'),
                          const SizedBox(height: 5),
                          _buildCard(2, '베케', 'assets/pictures/veke.png'),
                          const SizedBox(height: 5),
                          _buildCard(3, '삼성혈', 'assets/pictures/samsung.png'),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* ### 하단 아이콘 ### */
            Align(
              alignment: Alignment.bottomCenter, // 가로 중앙, 세로 하단 정렬
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0), // 하단 패딩
                child: SvgPicture.asset('assets/icons/Down.svg'), // 아래 화살표 아이콘
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ### 여행지 카드 생성 함수 ### */
  Widget _buildCard(int index, String title, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 카드 모서리 둥글게
      ),
      elevation: 0, // 그림자 없음
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // 카드 내부 이미지 모서리 둥글게
        child: Stack(
          children: [
            /* ### 여행지 이미지 ### */
            Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 220),
            /* ### 여행지 이름 ### */
            Positioned(
              bottom: 10,
              left: 15,
              child: Text(
                title,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            /* ### 즐겨찾기 버튼 ### */
            Positioned(
              bottom: 15,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  // 즐겨찾기 상태 토글
                  setState(() {
                    isFavoriteList[index] = !isFavoriteList[index];
                  });
                },
                child: SvgPicture.asset(
                  isFavoriteList[index] ? 'assets/icons/Heart_f.svg' : 'assets/icons/Heart.svg',
                  colorFilter: ColorFilter.mode(
                    isFavoriteList[index] ? const Color(0xFFFF5555) : const Color(0xFFFFFFFF), // 즐겨찾기 상태에 따른 색상
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
