import 'package:flutter/material.dart';

/* ##### 해시태그 여행 루트 상세 페이지 ##### */
class HashDetailRoute extends StatefulWidget {
  final String selectedKeyword; // 선택한 키워드

  const HashDetailRoute({super.key, required this.selectedKeyword});

  @override
  State<HashDetailRoute> createState() => _HashDetailRouteState();
}

class _HashDetailRouteState extends State<HashDetailRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* ### 뒤로가기 버튼 및 키워드 헤더 ### */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, widget.selectedKeyword); // 뒤로가기
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: Color(0xFF000000), // 아이콘 색상
                        ),
                      ),
                      buildKeywordHeader(), // 키워드 헤더
                    ],
                  ),
                  const SizedBox(height: 35),
                  /* ### 여행지 카드 리스트 ### */
                  Column(
                    children: [
                      buildCard(
                        '삼성혈', 
                        'assets/pictures/samsung.png', 
                        '제주 제주시 삼성로 22', 
                        """제주 시내에 위치해 있어 여행의 시작점으로 좋습니다.\n이곳에서 제주도의 역사와 문화를 간단히 알아보세요."""
                      ),  
                      buildtime(30), // 소요시간
                      buildCard(
                        '카멜리아힐', 
                        'assets/pictures/camellia.png', 
                        '제주 서귀포시 안덕면 병악로 166', 
                        "아름다운 차밭과 꽃들이 있는 곳이니 여유롭게 구경하세요."
                      ),
                      buildtime(15),
                      buildCard(
                        '생각하는 정원', 
                        'assets/pictures/garden.png', 
                        '제주 제주시 한경면 녹차분재로 675', 
                        "다양한 식물과 예쁜 경관을 즐길 수 있는 곳입니다."
                      ),
                      buildtime(20),
                      buildCard(
                        '베케', 
                        'assets/pictures/veke.png', 
                        '제주 서귀포시 효돈로 48', 
                        "이곳에서 제주 베케의 아름다움을 만끽하세요."
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ### 키워드 헤더 위젯 ### */
  Widget buildKeywordHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 패딩 설정
      decoration: BoxDecoration(
        color: const Color(0xFF497F5B), // 배경색
        borderRadius: BorderRadius.circular(25), // 둥근 모서리
      ),
      child: Text(
        '옵써가 계획한 ${widget.selectedKeyword} 여행루트예요.', // 선택한 키워드 표시
        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16), // 텍스트 스타일
      ),
    );
  }

  /* ### 여행지 카드 위젯 ### */
  Widget buildCard(String title, String image, String location, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        // 여행지 이름
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800), // 제목 스타일
        ),
        const SizedBox(height: 10),
        // 여행지 이미지
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // 이미지 모서리 둥글게
            child: Image.asset(
              image, // 이미지 경로
              width: 250, // 이미지 가로 크기
              height: 190, // 이미지 세로 크기
              fit: BoxFit.cover, // 이미지 크기 맞춤
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 위치 정보
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined, color: Color(0xFF000000)), // 위치 아이콘
              Text(location, style: const TextStyle(fontSize: 17)), // 위치 텍스트
            ],
          ),
        ),
        const SizedBox(height: 8),
        // 여행지 설명
        Center(
          child: Text(text, style: const TextStyle(fontSize: 13)), // 설명 텍스트
        ),
      ],
    );
  }

  /* ### 소요시간 표시 위젯 ### */
  Widget buildtime(int time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20), // 세로 패딩
      child: Stack(
        children: [
          const Positioned(
            left: 15, 
            child: Icon(Icons.more_vert, color: Color(0xFF000000)), // 세로 점 아이콘
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '소요시간 $time분', 
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700), // 소요시간 텍스트
              ),
            ],
          ),
        ],
      ),
    );
  }
}
