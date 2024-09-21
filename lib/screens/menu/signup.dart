import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
  Color nameBorderColor = const Color(0xFFC5C6CC); 
  Color emailBorderColor = const Color(0xFFC5C6CC); 
  Color passwordBorderColor = const Color(0xFFC5C6CC); 
  Color confirmPasswordBorderColor = const Color(0xFFC5C6CC); 

  @override
  void initState() {
    super.initState();

    // FocusNode의 이벤트 리스너 설정
    nameFocusNode.addListener(() {
      setState(() {
        nameBorderColor = nameFocusNode.hasFocus ? const Color(0xFF497F5B) : const Color(0xFFC5C6CC);
      });
    });

    emailFocusNode.addListener(() {
      setState(() {
        emailBorderColor = emailFocusNode.hasFocus ? const Color(0xFF497F5B) : const Color(0xFFC5C6CC);
      });
    });

    passwordFocusNode.addListener(() {
      setState(() {
        passwordBorderColor = passwordFocusNode.hasFocus ? const Color(0xFF497F5B) : const Color(0xFFC5C6CC);
      });
    });

    confirmPasswordFocusNode.addListener(() {
      setState(() {
        confirmPasswordBorderColor = confirmPasswordFocusNode.hasFocus ? const Color(0xFF497F5B) : const Color(0xFFC5C6CC);
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
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이름',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
                  color: nameBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: nameFocusNode,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '이름',
                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300 ,color: Color(0xFF8F9098)), // 힌트 색상
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이메일',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
                  color: emailBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '이메일',
                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300 ,color: Color(0xFF8F9098)), // 힌트 색상
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
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
                  hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300 ,color: Color(0xFF8F9098)), // 힌트 색상
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, size: 24, color: const Color(0xFFC5C6CC)),
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
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.3,
                  color: confirmPasswordBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: confirmPasswordFocusNode,
                obscureText: !isVisible,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '비밀번호 확인',
                  hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300 ,color: Color(0xFF8F9098)), // 힌트 색상
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
