import 'package:flutter/material.dart';
import 'package:obsser_1/screens/new_trip/new_trip_date.dart';
import 'dart:math'; // 랜덤 숫자 생성을 위해 추가

/* ##### 새로운 여행 만들기 화면 ##### */
class NewTScreen extends StatefulWidget {
  const NewTScreen({super.key});

  @override
  State<NewTScreen> createState() => _NewTScreenState();
}

class _NewTScreenState extends State<NewTScreen> {
  bool isNextEnabled = false; // '다음' 버튼 활성화 여부
  final TextEditingController _controller = TextEditingController(); // 여행 제목 입력 컨트롤러

  // 랜덤 제목 리스트
  final List<String> randomTitles = [
    '힐링하러 떠나는 제주도',
    '제주의 바람을 느끼다',
    '자연과 함께하는 힐링 제주',
    '푸른 여정',
    '제주 바다를 담은 하루',
    '유채꽃과 함께 걷는 제주',
    '돌담길 따라 만나는 제주의 숨결',
    '한라산에서 제주를 바라보다',
    '제주의 별빛 아래, 낭만 여행',
    '제주 미식 여행',
    '제주의 숨은 보석, 비밀 여행지 탐방',
    '제주 해수욕장 투어',
    '친환경 여행으로 떠나보자',
    '제주 문화의 매력 체험하기',
    '차타고 제주도 드라이브',
  ];

  // 랜덤 제목 선택 함수
  void _setRandomTitle() {
    final random = Random();
    setState(() {
      _controller.text = randomTitles[random.nextInt(randomTitles.length)]; // 랜덤 제목 선택
    });
  }

  @override
  void initState() {
    super.initState();
    // 텍스트 필드 값 변경 시 '다음' 버튼 상태 업데이트
    _controller.addListener(() {
      setState(() {
        isNextEnabled = _controller.text.isNotEmpty; // 텍스트 필드가 비어있지 않으면 버튼 활성화
      });
    });
  }

  // ### '다음' 버튼 UI 및 동작 ###
  Widget _buildPNButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 170), // 추가된 여백
        const SizedBox(width: 25),
        ElevatedButton(
          onPressed: isNextEnabled
              ? () {
                  // '다음' 버튼 클릭 시 동작
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTDateScreen(
                        tripTitle: _controller.text, // 입력된 여행 제목 전달
                      ),
                    ),
                  );
                }
              : null, // 비활성화된 버튼 상태
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B), // 활성화된 버튼 색상
            foregroundColor: const Color(0xFFFFFFFF), // 활성화된 텍스트 색상
            disabledForegroundColor: const Color(0xFFFFFFFF), // 비활성화된 텍스트 색상
            disabledBackgroundColor: const Color(0xFFFFDEA0), // 비활성화된 버튼 색상
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 60), // 버튼 크기 설정
            elevation: 0,
          ),
          child: const Text('다음', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  // ### 제목 입력 페이지 UI ###
  Widget _buildTitlePage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 150, 40, 0), // 상단 여백과 패딩 설정
      child: Column(
        children: [
          const Center(
            child: Text(
              '여행 제목을 입력하세요!', // 안내 텍스트
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 20), // 텍스트와 입력 필드 사이의 간격
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 1.3, color: const Color(0xFFC5C6CC)), // 입력 필드 테두리 색상
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _controller, // 텍스트 필드에 연결된 컨트롤러
                decoration: InputDecoration(
                  border: InputBorder.none, // 테두리 제거
                  hintText: '힐링하러 떠나는 제주도', // 텍스트 힌트
                  hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xFFC5C6CC)),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.autorenew, size: 28, color: Color(0xFF477C59)), // 리프레시 아이콘
                    onPressed: _setRandomTitle, // 랜덤 제목 설정
                  ),
                  suffixIconConstraints: const BoxConstraints(maxWidth: 30, maxHeight: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경 색상
      body: Column(
        children: [
          _buildTitlePage(), // 제목 입력 페이지
          const Spacer(), // 화면 아래로 '다음' 버튼을 밀기 위한 Spacer
          _buildPNButton(), // '다음' 버튼
          const SizedBox(height: 60), // 하단 여백
        ],
      ),
    );
  }
}
