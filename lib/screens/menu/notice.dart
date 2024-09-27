import 'package:flutter/material.dart';

/* ##### 공지사항 화면 ##### */
class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: Column(
        children: [
          /* ### 상단 네비게이션 바 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 0), // 패딩 설정
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
          /* ### 공지사항 항목 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20), // 내부 패딩 설정
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30), // 상단 여백
                      GestureDetector(
                        onTap: () {
                          // 여기에 원하는 동작 추가 (공지사항 클릭 시)
                        },
                        /* ### 공지사항 내용 ### */
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                              children: [
                                Text(
                                  ' 옵써 첫 업데이트 소식', // 공지 제목
                                  style: TextStyle(
                                    fontSize: 22, 
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ' 2024.10.04', // 날짜
                                  style: TextStyle(
                                    fontSize: 20, 
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios, // 오른쪽 화살표 아이콘
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15), // 항목 간 여백
                      /* ### 구분선 ### */
                      Container(
                        width: double.infinity,
                        height: 2, // 구분선 높이
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9D9D9), // 구분선 색상
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
