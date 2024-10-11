import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obsser_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:obsser_1/screens/menu_screen.dart';

/* ##### 계정 설정 화면 ##### */
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  File? _imageFile; // 프로필 사진을 저장할 변수

  // 프로필 사진 변경 메서드
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path); // 선택한 이미지를 File 객체로 변환
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MenuScreen(imageFile: _imageFile!), // MenuScreen으로 이미지 파일 전달
        ),
      );
    }
  }

  /* 로그아웃 함수 */
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('email');
    await prefs.remove('name');

    // MenuScreen으로 돌아가서 로그아웃 상태로 화면을 갱신
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(initialIndex: 3), // '나의 일정' 탭으로 이동
      ),
      (route) => false, // 뒤로가기 버튼을 비활성화하여 이전 페이지로 돌아가지 않음
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: Stack(
              children: [
                Positioned(
                  left: 15,
                  top: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios, 
                      color: Color(0xFF000000), 
                      size: 24,
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '계정 설정',
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
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: _pickImage, // 메서드 호출로 변경
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              ' 프로필 사진 변경',
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40), // 항목 간 여백

                      GestureDetector(
                        onTap: () => _logout(context), // 로그아웃 버튼 클릭 시 동작
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' 로그아웃',
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          // 회원 탈퇴 기능 추가
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' 회원 탈퇴',
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
