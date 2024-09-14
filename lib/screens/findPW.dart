import 'package:flutter/material.dart';

class FindpwScreen extends StatefulWidget {
  @override
  _FindpwScreenState createState() => _FindpwScreenState();
}

class _FindpwScreenState extends State<FindpwScreen> {
  final FocusNode emailFocusNode = FocusNode(); // 이메일 입력창의 FocusNode
  Color emailBorderColor = Color(0xFFC5C6CC); // 이메일 입력창 테두리 색상

  @override
  void initState() {
    super.initState();
    // FocusNode의 이벤트 리스너 설정
    emailFocusNode.addListener(() {
      setState(() {
        emailBorderColor = emailFocusNode.hasFocus ? Color(0xFF497F5B) : Color(0xFFC5C6CC); // 포커스 상태에 따라 색상 변경
      });
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose(); // FocusNode 해제
    super.dispose();
  }

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
                fontSize: 65,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: Text(
              '비밀번호 찾기',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Center(
            child: Text(
              '비밀번호를 찾고자하는 아이디를 입력하세요.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF626262),
              ),
            ),
          ),
          Center(
            child: Text(
              '가입하신 이메일로 메일이 전송됩니다.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF626262),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
                  color: emailBorderColor // 테두리 색상 변경
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: emailFocusNode, // FocusNode 연결
                decoration: InputDecoration(
                  border: InputBorder.none, // 테두리 없음
                  hintText: '아이디를 입력해 주세요.', // 힌트 텍스트
                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300 ,color: Color(0xFF8F9098)), // 힌트 색상
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // 이메일 보내기 로직
              },
              child: Text(
                '이메일 보내기',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 18),
                backgroundColor: Color(0xFF497F5B),
                foregroundColor: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(170, 55),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
