import 'package:flutter/material.dart';
import 'package:obsser_1/main.dart';
import 'package:obsser_1/screens/menu/login_screen.dart';
import 'package:obsser_1/screens/menu/myfavorite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:obsser_1/screens/menu/inquiry.dart';
import 'package:obsser_1/screens/menu/notice.dart';
import 'package:obsser_1/screens/menu/notification.dart';
import 'package:obsser_1/screens/menu/setting.dart';
import 'package:obsser_1/screens/menu/service.dart';

/* ##### 메뉴 페이지 ##### */
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoggedIn = false; // 로그인 상태 저장 변수
  String? email;
  String? name;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // 로그인 상태 확인
    _getEmail();
  }

  /* ### 로그인 상태 확인 함수 ### */
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  /* ### 저장된 이메일 가져오기 ### */
  Future<void> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      email = prefs.getString('email') ?? 'example@gmail.com'; // 이메일 없으면 기본값으로 설정
      name = prefs.getString('name') ?? '로그인하세요';
    });
  }

  /* ### 로그인 상태 저장 함수 ### */
  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    setState(() {
      isLoggedIn = true;
      _getEmail();
    });
  }

  /* ### 로그아웃 함수 ### */
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
      email = 'example@gmail.com';
      name = '로그인하세요';
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
            padding: const EdgeInsets.fromLTRB(40, 100, 40, 40),
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
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
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
          color: Colors.grey.withOpacity(0.2),
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
                        name ?? '로그인하세요', // 로그인 상태에 따른 텍스트
                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        email ?? 'example@gmail.com', // 로그인된 이메일 또는 기본 텍스트
                        style: const TextStyle(fontSize: 12, color: Color(0xFF727272)),
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
            child: _buildMenuRow(' 나의 관심'), // 관심장소 메뉴
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              // '나의 일정' 클릭 시 'MainPage'로 이동하며, initialIndex를 2로 설정
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(initialIndex: 2), // '나의 일정' 탭으로 이동
                ),
                (route) => false, // 뒤로가기 버튼을 비활성화하여 이전 페이지로 돌아가지 않음
              );
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
          _buildSettingsRow(' 서비스 이용 약관', const ServiceScreen()), // 서비스 약관 메뉴
          const SizedBox(height: 40),
          _buildAppVersionRow(' 앱버전', '1.0.0'), // 앱버전 메뉴 - 팝업 추가
          const SizedBox(height: 40),
          if (isLoggedIn) // 로그인 상태일 때만 로그아웃 버튼을 표시
            GestureDetector(
              onTap: _logout, // 로그아웃 버튼 클릭 시 동작
              child: _buildMenuRow(' 로그아웃'),
            ),
        ],
      ),
    );
  }

  /* ### 앱버전 메뉴 항목 생성 함수 ### */
  Widget _buildAppVersionRow(String title, String version) {
    return GestureDetector(
      onTap: () {
        _showVersionDialog(version); // 앱 버전 팝업을 띄우는 함수 호출
      },
      child: _buildMenuRow(title),
    );
  }

  /* ### 앱버전 팝업 표시 함수 ### */
  void _showVersionDialog(String version) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('현재 앱 버전은 $version 입니다.'),
          content: Image.asset('assets/splash.png'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF121212),
              ),
              child: const Text('확인'),
            ),
          ],
        );
      },
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
