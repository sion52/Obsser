import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTBackScreen extends StatefulWidget {
  final String tripTitle;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  const NewTBackScreen({super.key, required this.tripTitle, required this.rangeStart, required this.rangeEnd});

  @override
  // ignore: library_private_types_in_public_api
  _NewTBackScreenState createState() => _NewTBackScreenState();
}

class _NewTBackScreenState extends State<NewTBackScreen> {
  bool isNextEnabled = true; // 다음 버튼 활성화 여부
  String selectedImage = 'assets/histories/back_0.png'; // 초기 이미지

  Widget _buildPNButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
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
              ? () {
                  // 다음 버튼 눌렀을 때 동작
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

  Widget _buildDatePage() {
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
        // 선택된 이미지가 표시될 큰 이미지 영역
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
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = images[0]; // 클릭된 이미지로 큰 이미지 변경
                  });
                },
                child: Container(
                  height: 100, // 고정된 높이
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: selectedImage == images[0] ? Colors.blue : Colors.transparent,
                      width: 3, // 선택된 이미지 강조
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15), // 이미지 사이의 간격
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = images[1]; // 클릭된 이미지로 큰 이미지 변경
                  });
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: selectedImage == images[1] ? Colors.blue : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = images[2]; // 클릭된 이미지로 큰 이미지 변경
                  });
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: selectedImage == images[2] ? Colors.blue : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = images[3]; // 클릭된 이미지로 큰 이미지 변경
                  });
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: selectedImage == images[3] ? Colors.blue : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images[3],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = images[4]; // 클릭된 이미지로 큰 이미지 변경
                  });
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: selectedImage == images[4] ? Colors.blue : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images[4],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          _buildDatePage(),
          const Spacer(),
          _buildPNButton(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
