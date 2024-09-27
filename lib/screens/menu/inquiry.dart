import 'package:flutter/material.dart';

/* ##### 문의 화면 ##### */
class InquiryScreen extends StatelessWidget {
  const InquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색 흰색
      body: Column(
        children: [
          /* ### 상단 네비게이션 바 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 0), // 상단 패딩 설정
            child: Stack(
              children: [
                /* ### 뒤로가기 버튼 ### */
                Positioned(
                  left: 15,
                  top: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // 뒤로가기 동작
                    },
                    child: const Icon(
                      Icons.arrow_back_ios, 
                      color: Color(0xFF000000), 
                      size: 24,
                    ),
                  ),
                ),
                /* ### 페이지 제목 ### */
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                  children: [
                    Text(
                      '공지사항', // 페이지 제목
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /* ### 문의 내역 섹션 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20), // 내부 패딩
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30), // 상단 간격
                      GestureDetector(
                        onTap: () {
                          // 여기에 원하는 동작 추가
                        },
                        /* ### 문의 내역 항목 ### */
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                              children: [
                                Text(
                                  ' 문의 내역', // 문의 내역 텍스트
                                  style: TextStyle(
                                    fontSize: 22, 
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios, // 우측 화살표 아이콘
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10), // 하단 간격
                    ],
                  ),
                ),
              ],
            ),
          ),
          /* ### 구분선 ### */
          Container(
            width: 350, // 구분선 너비
            height: 3,  // 구분선 높이
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9), // 구분선 색상
            ),
          ),
        ],
      ),
    );
  }
}
