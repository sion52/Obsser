import 'package:flutter/material.dart';
import 'package:obsser_1/screens/signup.dart';
import 'package:obsser_1/screens/findPW.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;
  final FocusNode emailFocusNode = FocusNode(); // 이메일 입력창의 FocusNode
  final FocusNode passwordFocusNode = FocusNode(); // 비밀번호 입력창의 FocusNode
  Color emailBorderColor = Color(0xFFC5C6CC); // 이메일 입력창 테두리 색상
  Color passwordBorderColor = Color(0xFFC5C6CC); // 비밀번호 입력창 테두리 색상

  @override
  void initState() {
    super.initState();
    // 이메일 FocusNode의 이벤트 리스너 설정
    emailFocusNode.addListener(() {
      setState(() {
        emailBorderColor = emailFocusNode.hasFocus ? Color(0xFF497F5B) : Color(0xFFC5C6CC); // 포커스 상태에 따라 색상 변경
      });
    });
    // 비밀번호 FocusNode의 이벤트 리스너 설정
    passwordFocusNode.addListener(() {
      setState(() {
        passwordBorderColor = passwordFocusNode.hasFocus ? Color(0xFF497F5B) : Color(0xFFC5C6CC); // 포커스 상태에 따라 색상 변경
      });
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose(); // 이메일 FocusNode 해제
    passwordFocusNode.dispose(); // 비밀번호 FocusNode 해제
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
          SizedBox(height: 10,),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: emailBorderColor, // 이메일 테두리 색상 변경
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: emailFocusNode, // 이메일 FocusNode 연결
                decoration: InputDecoration(
                  border: InputBorder.none, // 테두리 없음
                  hintText: '이메일을 입력해 주세요.', // 힌트 텍스트
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFC5C6CC)), // 힌트 색상
                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: passwordBorderColor, // 비밀번호 테두리 색상 변경
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: passwordFocusNode, // 비밀번호 FocusNode 연결
                obscureText: !isVisible, // 비밀번호 숨기기 설정
                decoration: InputDecoration(
                  border: InputBorder.none, // 테두리 없음
                  hintText: '비밀번호를 입력해 주세요.', // 힌트 텍스트
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFC5C6CC)), // 힌트 색상
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 24, color: Color(0xFFC5C6CC),),
                    onPressed: () {
                      // 비밀번호 표시
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 35,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // 로그인 로직
              },
              child: Text(
                '로그인',
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
          SizedBox(height: 20,),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FindpwScreen()),
                );
              },
              child: Text(
                '비밀번호를 잊으셨나요?',
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF626262),
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '계정이 없으신가요? ',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF626262),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text(
                    '가입하기',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF488A5F),
                    ),
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
