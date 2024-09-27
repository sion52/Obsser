import 'package:flutter/material.dart';
import 'package:obsser_1/screens/menu/login_screen.dart';
import 'package:obsser_1/screens/menu/myfavorite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:obsser_1/screens/menu/inquiry.dart';
import 'package:obsser_1/screens/menu/notice.dart';
import 'package:obsser_1/screens/menu/notification.dart';
import 'package:obsser_1/screens/menu/setting.dart';

/* ##### 메뉴 페이지 ##### */
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoggedIn = false; // 로그인 상태 저장 변수

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // 로그인 상태 확인
  }

  /* ### 로그인 상태 확인 함수 ### */
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  /* ### 로그인 상태 저장 함수 ### */
  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    setState(() {
      isLoggedIn = true;
    });
  }

  /* ### 로그아웃 함수 ### */
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
  }

  /* ### 메뉴 화면 구성 ### */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 흰색
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 100, 40, 20),
            child: Column(
              children: [
                _buildProfileSection(), // 프로필 섹션
                const SizedBox(height: 30),
                _buildMenuOptions(), // 나의 관심장소 및 나의 일정 섹션
              ],
            ),
          ),
          _buildDivider(), // 구분선
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: _buildSettingsOptions(), // 설정 메뉴 섹션
          ),
        ],
      ),
    );
  }

  /* ### 프로필 섹션 위젯 ### */
  Widget _buildProfileSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1EA),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 3),
        )],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (!isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn(onLogin: _login)),
                  );
                }
              },
              child: Row(
                children: [
                  Image.asset('assets/profile.png', width: 50, height: 50), // 프로필 이미지
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLoggedIn ? '옵써' : '로그인하세요', // 로그인 상태에 따른 텍스트
                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        'example@gmail.com', // 이메일 텍스트 (고정)
                        style: TextStyle(fontSize: 12, color: Color(0xFF727272)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingScreen()),
                );
              },
              child: const Icon(Icons.settings_outlined, size: 40), // 설정 아이콘
            ),
          ],
        ),
      ),
    );
  }

  /* ### 나의 관심장소 및 나의 일정 섹션 ### */
  Widget _buildMenuOptions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen()),
              );
            },
            child: _buildMenuRow(' 나의 관심장소'), // 관심장소 메뉴
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              // 나의 일정 클릭 시 동작
            },
            child: _buildMenuRow(' 나의 일정'), // 나의 일정 메뉴
          ),
        ],
      ),
    );
  }

  /* ### 구분선 위젯 ### */
  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 3,
      color: const Color(0xFFD9D9D9), // 구분선 색상
    );
  }

  /* ### 설정 메뉴 섹션 ### */
  Widget _buildSettingsOptions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          _buildSettingsRow(' 공지사항', const NoticeScreen()), // 공지사항 메뉴
          const SizedBox(height: 40),
          _buildSettingsRow(' 알림 설정', const NotificationScreen()), // 알림 설정 메뉴
          const SizedBox(height: 40),
          _buildSettingsRow(' 1:1 문의', const InquiryScreen()), // 1:1 문의 메뉴
          const SizedBox(height: 40),
          _buildSettingsRow(' 서비스 약관', null), // 서비스 약관 메뉴
          const SizedBox(height: 40),
          _buildSettingsRow(' 앱버전', null), // 앱버전 메뉴
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _logout, // 로그아웃 버튼 클릭 시 동작
            child: _buildMenuRow(' 로그아웃'),
          ),
        ],
      ),
    );
  }

  /* ### 설정 메뉴 항목 위젯 생성 함수 ### */
  Widget _buildSettingsRow(String title, Widget? screen) {
    return GestureDetector(
      onTap: () {
        if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        }
      },
      child: _buildMenuRow(title),
    );
  }

  /* ### 메뉴 항목 위젯 생성 함수 ### */
  Widget _buildMenuRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        const Icon(Icons.arrow_forward_ios), // 오른쪽 화살표 아이콘
      ],
    );
  }
}
