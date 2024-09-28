import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* ##### 알림 설정 화면 ##### */
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isChecked = false; // 야간 수신 스위치 상태를 저장하는 변수

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  /* ### 스위치 상태 로드 ### */
  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = prefs.getBool('isNightReceiveChecked') ?? false;
    });
  }

  /* ### 스위치 상태 저장 ### */
  Future<void> _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNightReceiveChecked', value);
  }

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
                  mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                  children: [
                    Text(
                      '알림 설정', // 페이지 제목
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
          /* ### 알림 설정 옵션 ### */
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 20), // 패딩 설정
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      /* ### 야간 수신 옵션 ### */
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F1EA), // 배경색
                          borderRadius: BorderRadius.circular(15), // 모서리 둥글게
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 내부 패딩 설정
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                            children: [
                              /* ### 야간 수신 설명 ### */
                              const Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                                    children: [
                                      Text(
                                        '야간 수신', // 옵션 제목
                                        style: TextStyle(
                                          fontSize: 19, 
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        """야간(21:00~08:00)에 광고성 푸시\n알림을 받을 수 있습니다.""", // 옵션 설명
                                        style: TextStyle(
                                          fontSize: 15, 
                                          color: Color(0xFF727272),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              /* ### 스위치 버튼 ### */
                              CupertinoSwitch(
                                value: _isChecked, // 스위치 상태
                                activeColor: CupertinoColors.activeGreen, // 활성화 상태 색상
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value ?? false; // 스위치 상태 변경
                                    _saveSwitchState(_isChecked);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      /* ### 정보성 푸시 알림 옵션 ### */
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F1EA), // 배경색
                          borderRadius: BorderRadius.circular(15), // 모서리 둥글게
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 내부 패딩
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                            children: [
                              /* ### 정보성 푸시 알림 설명 ### */
                              const Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                                    children: [
                                      Text(
                                        """정보성 푸시 알림은 위 설정 여부와는 무관\n하게 받을 수 있습니다. 기기의 알림 설정은\n'휴대폰 설정 > 알림 > 옵써'에서 변경 할\n수 있습니다.""", // 옵션 설명
                                        style: TextStyle(
                                          fontSize: 15, 
                                          color: Color(0xFF000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              /* ### 알림 설정 변경 아이콘 ### */
                              GestureDetector(
                                onTap: () {
                                  // 알림 설정 변경 클릭 시 동작 추가
                                },
                                child: const Icon(Icons.arrow_forward_ios, size: 25),
                              ),
                            ],
                          ),
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
