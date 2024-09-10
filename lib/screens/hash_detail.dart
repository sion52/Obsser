import 'package:flutter/material.dart';

class HashDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38, 50, 38, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildKeywordHeader(), // 키워드 헤더 위젯
              SizedBox(height: 8,),
              buildKeywordChips(), // 키워드 칩 위젯
            ],
          ),
        ),
      ),
    );
  }

  // 키워드별 여행지 헤더
  Widget buildKeywordHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '키워드별',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF497F5B)),
              ),
              TextSpan(
                text: ' 여행지',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 키워드 칩 리스트
  Widget buildKeywordChips() {
    List<String> keywords = ['#한적한', '#감성적인', '#휴양지', '#맛집', '#야경', '#여유로운', '#술', "#촬영지", "#드라이브", ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 183, // 칩 리스트 높이
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF), // 배경색
          borderRadius: BorderRadius.circular(20), // 모서리 둥글게
          border: Border.all(
            width: 1,
            color: Color(0xA6A4A4A4)
          )
        ),
        child: GridView.builder(
          padding: EdgeInsets.fromLTRB(8, 14, 8, 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3개의 열
            childAspectRatio: 1.9, // 버튼 비율
          ),
          itemCount: keywords.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 시 동작
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${keywords[index]} 클릭됨')),
                  );
                },
                child: Text(
                  keywords[index],
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  backgroundColor: Color(0xFFE8F1EA), // 버튼 배경색
                  foregroundColor: Color(0xFF000000), // 버튼 텍스트 색
                  elevation: 0, // 그림자 제거
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
