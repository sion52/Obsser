import 'package:flutter/material.dart';

/* ##### 계정 설정 화면 ##### */
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
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
                      Navigator.pop(context); // 이전 화면으로 돌아가기
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
                  mainAxisAlignment: MainAxisAlignment.center, // 제목을 중앙 정렬
                  children: [
                    Text(
                      '계정 설정', // 페이지 제목
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

          /* ### 설정 옵션 리스트 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 20), // 패딩 설정
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30), // 상단 여백

                      /* ### 프로필 사진 변경 옵션 ### */
                      GestureDetector(
                        onTap: () {
                          // 프로필 사진 변경 기능 추가
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                          children: [
                            Text(
                              ' 프로필 사진 변경', // 설정 항목 제목
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios, // 오른쪽 화살표 아이콘
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40), // 항목 간 여백

                      /* ### 로그아웃 옵션 ### */
                      GestureDetector(
                        onTap: () {
                          // 로그아웃 기능 추가
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                          children: [
                            Text(
                              ' 로그아웃', // 설정 항목 제목
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40), // 항목 간 여백

                      /* ### 회원 탈퇴 옵션 ### */
                      GestureDetector(
                        onTap: () {
                          // 회원 탈퇴 기능 추가
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                          children: [
                            Text(
                              ' 회원 탈퇴', // 설정 항목 제목
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.w700,
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
          ),
        ],
      ),
    );
  }
}
