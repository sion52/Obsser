import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:obsser_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* ##### 새로운 여행 이미지 선택 화면 ##### */
class NewTBackScreen extends StatefulWidget {
  final String tripTitle; // 여행 제목
  final String rangeStart; // 여행 시작 날짜
  final String rangeEnd; // 여행 종료 날짜

  const NewTBackScreen({super.key, required this.tripTitle, required this.rangeStart, required this.rangeEnd});

  @override
  State<NewTBackScreen> createState() => _NewTBackScreenState();
}

class _NewTBackScreenState extends State<NewTBackScreen> {
  bool isNextEnabled = true; // 다음 버튼 활성화 여부
  String selectedImage = 'assets/histories/back_0.png'; // 초기 선택 이미지

  // ### 서버로 여행 데이터를 전송하는 함수 ### 
  Future<void> saveTravelData(String title, String startDate, String endDate, String imageUrl) async {
    // 날짜를 DateTime 형식으로 변환
    DateFormat dateFormat = DateFormat('yyyy.MM.dd'); // 날짜 형식 지정
    DateTime startDateTime = dateFormat.parse(startDate);
    DateTime endDateTime = dateFormat.parse(endDate);

    // yyyymmdd 형식으로 변환
    String formattedStartDate = "${startDateTime.year}${_twoDigits(startDateTime.month)}${_twoDigits(startDateTime.day)}";
    String formattedEndDate = "${endDateTime.year}${_twoDigits(endDateTime.month)}${_twoDigits(endDateTime.day)}";

    // 두 날짜를 이어붙여 16자리 숫자 문자열 생성 후 int로 변환
    int formattedDate = int.parse("$formattedStartDate$formattedEndDate");

    // // SharedPreferences에서 이메일을 가져옴
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    // 서버에 POST 요청
    final response = await http.post(
      Uri.parse('http://3.37.197.251:5000/mytrip/addmytrip'), // 서버 주소 (환경에 맞게 수정)
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{ // 'date'를 int로 전송하기 위해 <String, dynamic> 사용
        'name': title,
        'date': formattedDate, // "yyyymmddyyyymmdd" 형식의 int 날짜
        'image_url': imageUrl, // 선택된 이미지 URL
      }),
    );

    if (response.statusCode == 200) {
      print("Travel data saved successfully");
    } else {
      print("Failed to save travel data: ${response.body}");
    }
  }


  // ### 두 자리 숫자를 맞추기 위한 헬퍼 함수 ###
  // 한 자릿수인 월과 일을 두 자리로 만들어주는 함수
  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0'); // 숫자가 한 자리일 경우 앞에 0을 붙임
  }

  // ### 이전 및 다음 버튼 UI 및 동작 정의 ###
  Widget _buildPNButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // 이전 버튼 클릭 시 이전 화면으로 이동
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFC5C6CC),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 60),
            elevation: 0,
          ),
          child: const Text('이전', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 25),
        ElevatedButton(
          onPressed: isNextEnabled
              ? () async {
                  // 다음 버튼 눌렀을 때 서버에 데이터 전송 및 메인 화면으로 이동
                  String startDate = widget.rangeStart.toString();
                  String endDate = widget.rangeEnd.toString();
                  await saveTravelData(widget.tripTitle, startDate, endDate, selectedImage);

                  // 메인 페이지로 이동하며 초기 인덱스를 2로 설정
                  Navigator.pushAndRemoveUntil(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(initialIndex: 2), // 메인 페이지의 2번째 탭으로 이동
                    ),
                    (Route<dynamic> route) => false, // 이전 페이지 스택을 모두 제거
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5),
            backgroundColor: const Color(0xFFFFC04B),
            foregroundColor: const Color(0xFFFFFFFF),
            disabledForegroundColor: const Color(0xFFFFFFFF),
            disabledBackgroundColor: const Color(0xFFFFDEA0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(170, 60),
            elevation: 0,
          ),
          child: const Text('다음', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  // ### 이미지 선택 화면 UI ###
  Widget _buildDatePage() {
    // 선택 가능한 이미지 목록
    List<String> images = [
      'assets/histories/back_0.png',
      'assets/histories/back_1.png',
      'assets/histories/back_2.png',
      'assets/histories/back_3.png',
      'assets/histories/back_4.png',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 150, 25, 0),
      child: Column(
        children: [
          const Center(
            child: Text(
              '여행에 어울리는 이미지를 선택해주세요!',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // 선택된 이미지가 표시되는 큰 이미지 영역
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              selectedImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100,
            ),
          ),
          const SizedBox(height: 15),

          // 이미지 선택을 위한 작은 이미지 목록
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = images[0]; // 클릭한 이미지로 변경
                    });
                  },
                  child: _buildImageCard(images[0], selectedImage == images[0]),
                ),
              ),
              const SizedBox(width: 15), // 이미지 사이의 간격
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = images[1];
                    });
                  },
                  child: _buildImageCard(images[1], selectedImage == images[1]),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = images[2];
                    });
                  },
                  child: _buildImageCard(images[2], selectedImage == images[2]),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = images[3];
                    });
                  },
                  child: _buildImageCard(images[3], selectedImage == images[3]),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = images[4];
                    });
                  },
                  child: _buildImageCard(images[4], selectedImage == images[4]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ### 이미지 선택 UI (작은 이미지 카드) ###
  Widget _buildImageCard(String imageUrl, bool isSelected) {
    return Container(
      height: 100, // 고정된 높이
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent, // 선택된 이미지 강조
          width: 3,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색 설정
      body: Column(
        children: [
          _buildDatePage(), // 이미지 선택 페이지
          const Spacer(), // 아래 버튼 영역을 위해 공간 확보
          _buildPNButton(), // 이전 및 다음 버튼
          const SizedBox(height: 60), // 버튼 아래 여백
        ],
      ),
    );
  }
}
