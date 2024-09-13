import 'package:flutter/material.dart';
import 'package:obsser_1/main.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '옵써',
              style: TextStyle(
                fontFamily: 'NanumMyeongjo',
                fontWeight: FontWeight.w700,
                fontSize: 60,
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xFF000000)
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, // 테두리 없음
                  hintText: '이메일을 입력해 주세요.', // 힌트 텍스트
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey), // 힌트 색상
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
