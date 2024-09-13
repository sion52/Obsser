import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisible = false;

  // FocusNode들
  final FocusNode nameFocusNode = FocusNode(); // 이름 입력창의 FocusNode
  final FocusNode emailFocusNode = FocusNode(); // 이메일 입력창의 FocusNode
  final FocusNode passwordFocusNode = FocusNode(); // 비밀번호 입력창의 FocusNode
  final FocusNode confirmPasswordFocusNode = FocusNode(); // 비밀번호 확인 입력창의 FocusNode

  // 각각의 테두리 색상
  Color nameBorderColor = Color(0xFFC5C6CC); 
  Color emailBorderColor = Color(0xFFC5C6CC); 
  Color passwordBorderColor = Color(0xFFC5C6CC); 
  Color confirmPasswordBorderColor = Color(0xFFC5C6CC); 

  @override
  void initState() {
    super.initState();

    // FocusNode의 이벤트 리스너 설정
    nameFocusNode.addListener(() {
      setState(() {
        nameBorderColor = nameFocusNode.hasFocus ? Color(0xFF497F5B) : Color(0xFFC5C6CC);
      });
    });

    emailFocusNode.addListener(() {
      setState(() {
        emailBorderColor = emailFocusNode.hasFocus ? Color(0xFF497F5B) : Color(0xFFC5C6CC);
      });
    });

    passwordFocusNode.addListener(() {
      setState(() {
        passwordBorderColor = passwordFocusNode.hasFocus ? Color(0xFF497F5B) : Color(0xFFC5C6CC);
      });
    });

    confirmPasswordFocusNode.addListener(() {
      setState(() {
        confirmPasswordBorderColor = confirmPasswordFocusNode.hasFocus ? Color(0xFF497F5B) : Color(0xFFC5C6CC);
      });
    });
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이름',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: nameBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: nameFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '이름',
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFC5C6CC)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이메일',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: emailBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '이메일',
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFC5C6CC)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: passwordBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: passwordFocusNode,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '비밀번호',
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFC5C6CC)),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 24, color: Color(0xFFC5C6CC)),
                    onPressed: () {
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
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: confirmPasswordBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: confirmPasswordFocusNode,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '비밀번호 확인',
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFC5C6CC)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
