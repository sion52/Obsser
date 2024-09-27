import 'package:flutter/material.dart';

/* ##### 비밀번호 찾기 화면 ##### */
class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: Padding(
        padding: const EdgeInsets.all(10.0), // 전체 패딩 설정
        child: Column(
          children: [
            /* ### 상단 여백 ### */
            const Padding(padding: EdgeInsets.only(top: 250)),

            /* ### 비밀번호 찾기 설명 ### */
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
                children: [
                  /* ### 앱 이름 ### */
                  const Text(
                    '옵써', // 앱 이름
                    style: TextStyle(
                      fontSize: 64.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NanumMyeongjo',
                      color: Colors.black,
                    ),
                  ),
                  /* ### 비밀번호 찾기 제목 ### */
                  const Text(
                    '비밀번호 찾기', // 페이지 제목
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  /* ### 설명 텍스트 ### */
                  const Text(
                    '비밀번호를 찾고자하는 아이디를 입력하세요.',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFF626262),
                    ),
                  ),
                  const Text(
                    '가입하신 이메일로 메일이 갑니다.',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFF626262),
                    ),
                  ),

                  const SizedBox(height: 10.0), // 간격

                  /* ### 이메일 입력 필드 ### */
                  TextField(
                    cursorColor: const Color(0xFF497F5B), // 커서 색상
                    decoration: InputDecoration(
                      labelText: '이메일을 입력해 주세요.', // 라벨 텍스트
                      labelStyle: const TextStyle(color: Color(0xFF8F9098)), // 라벨 색상
                      floatingLabelStyle: const TextStyle(color: Color(0xFF1F2024)), // 플로팅 라벨 색상
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFC5C6CC)), // 기본 테두리
                        borderRadius: BorderRadius.circular(15.0), // 테두리 둥글게
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF497F5B)), // 포커스 상태 테두리
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress, // 이메일 입력용 키보드
                  ),

                  const SizedBox(height: 10.0), // 간격

                  /* ### 이메일 보내기 버튼 ### */
                  ButtonTheme(
                    minWidth: 160.0,
                    height: 42.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // 이메일 보내기 기능 추가
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(160, 52), // 버튼 크기
                        backgroundColor: const Color(0xFF497F5B), // 버튼 색상
                      ),
                      child: const Text(
                        '이메일 보내기', // 버튼 텍스트
                        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
